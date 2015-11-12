//
//  SentMemeViewController.swift
//  MemeMe
//
//  Created by Daniele Vitali on 11/7/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class SentMemeViewController: UIViewController {
    
    var memes: [Meme]! {
        get {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            return appDelegate.memes
        }
        set(newMemes) {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.memes = newMemes
        }
    }
    
    var memeAtIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "createMeme")
    }
    
    func showMeme(atIndex index: Int) {
        memeAtIndex = index
        performSegueWithIdentifier("showMemeSegue", sender: self)
    }
    
    func createMeme() {
        performSegueWithIdentifier("createMemeSegue", sender: self)
    }
    
    func editMeme(atIndex index: Int) {
        memeAtIndex = index
        performSegueWithIdentifier("createMemeSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case  "showMemeSegue":
            let controller = segue.destinationViewController as! OpenMemeViewController
            controller.memeAtIndex = memeAtIndex
            break
        case  "createMemeSegue":
            if let editMemeAtIndex = memeAtIndex {
                let controller = segue.destinationViewController as! CreateMemeViewController
                controller.editAtIndex = editMemeAtIndex
                self.memeAtIndex = nil
            }
            break
        default: break
        }
    }
    
}