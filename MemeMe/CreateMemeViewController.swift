//
//  ViewController.swift
//  MemeMe
//
//  Created by Daniele Vitali on 10/31/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let bottomTextFieldDelegate = TextFieldDelegate(placeholder: "BOTTOM")
    let topTextFieldDelegate = TextFieldDelegate(placeholder: "TOP")
    var editAtIndex: Int?
    var memedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = topTextFieldDelegate
        bottomTextField.delegate = bottomTextFieldDelegate
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let editAtIndex = editAtIndex {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let meme = appDelegate.memes[editAtIndex]
            topTextField.text = meme.topText
            bottomTextField.text = meme.bottomText
            imageView.image = meme.image
            imageView.contentMode = .ScaleAspectFit
            shareButton.enabled = true
        }

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) && bottomBar.items!.count == 2 {
            //Leaving the camera button visible might be misleading. So, hide/remove the button
            bottomBar.items!.removeLast()
        }
        if imageView.image == nil {
            shareButton.enabled = false
        }
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        pickAnImage(.PhotoLibrary)
    }

    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        pickAnImage(.Camera)
    }
    
    func pickAnImage(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissModallyViewController()
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            shareButton.enabled = true
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissModallyViewController()
    }
    
    func dismissModallyViewController() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if view.frame.origin.y == 0 && bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func generateMemedImage() -> UIImage {
        topBar.hidden = true
        bottomBar.hidden = true

        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topBar.hidden = false
        bottomBar.hidden = false
        
        return memedImage
    }
    
    @IBAction func shareClick(sender: AnyObject) {
        
        memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage!], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func closeClick(sender: AnyObject) {
        dismissModallyViewController()
    }
    
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memeImage: memedImage!)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let editAtIndex = editAtIndex {
            appDelegate.memes.removeAtIndex(editAtIndex)
        }
        appDelegate.memes.insert(meme, atIndex: 0)
        dismissModallyViewController()
    }
}

