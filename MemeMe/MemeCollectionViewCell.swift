//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Daniele Vitali on 11/7/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    func setMeme(meme: Meme) {
        memeImageView.image = meme.memeImage
    }
}
