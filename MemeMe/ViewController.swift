//
//  ViewController.swift
//  MemeMe
//
//  Created by Daniele Vitali on 10/31/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let textFieldDelegate = TextFieldDelegate()
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 2
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) && bottomBar.items!.count == 2 {
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: bottomTextField)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: bottomTextField)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func generateMemedImage() -> UIImage {
        topBar.hidden = true
        bottomBar.hidden = true

        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topBar.hidden = false
        bottomBar.hidden = false
        
        return memedImage
    }
    
    @IBAction func shareClick(sender: AnyObject) {
        
        let memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(items![0] as! UIImage)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func save(memedImage: UIImage) {
        meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memeImage: memedImage)
    }
}

