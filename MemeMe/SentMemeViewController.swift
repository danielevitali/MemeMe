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
    
    var memes: [Meme]!
    var selectedMeme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .Plain, target: self, action: "createMeme")
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    func createMeme() {
        performSegueWithIdentifier("createMemeSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "openMemeSegue" {
            let controller = segue.destinationViewController as! OpenMemeViewController
            controller.meme = selectedMeme
        }
    }
    
}