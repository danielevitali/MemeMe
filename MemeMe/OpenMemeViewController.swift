//
//  OpenMemeViewController.swift
//  MemeMe
//
//  Created by Daniele Vitali on 11/7/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class OpenMemeViewController: UIViewController {
    
    var memeAtIndex: Int!
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editMeme")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let meme = appDelegate.memes[memeAtIndex]
        memeImageView.image = meme.memeImage
    }
    
    func editMeme() {
        performSegueWithIdentifier("editMemeSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! CreateMemeViewController
        controller.editAtIndex = memeAtIndex
    }
}