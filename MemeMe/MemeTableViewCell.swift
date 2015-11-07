//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Daniele Vitali on 11/7/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewCell: UITableViewCell{
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!

    func setMeme(meme: Meme) {
        memeImageView.image = meme.image
        memeLabel.text = "\(meme.topText) ... \(meme.bottomText)"
    }
}
