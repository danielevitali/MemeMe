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
    var selectedMeme: Meme?
    var editMemeAtIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "createMeme")
    }
    
    func createMeme() {
        performSegueWithIdentifier("createMemeSegue", sender: self)
    }
    
    func editMeme(atIndex index: Int) {
        editMemeAtIndex = index
        performSegueWithIdentifier("createMemeSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case  "openMemeSegue":
            let controller = segue.destinationViewController as! OpenMemeViewController
            controller.meme = selectedMeme
            break
        case  "createMemeSegue":
            if let editMemeAtIndex = editMemeAtIndex {
                let controller = segue.destinationViewController as! CreateMemeViewController
                controller.editAtIndex = editMemeAtIndex
            }
            break
        default: break
        }
    }
    
}