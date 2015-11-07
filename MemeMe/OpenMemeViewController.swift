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
    
    var meme: Meme!
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImageView.image = meme.memeImage
    }
}