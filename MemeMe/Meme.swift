//
//  Meme.swift
//  MemeMe
//
//  Created by Daniele Vitali on 11/1/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class Meme {
    var topText: String
    var bottomText: String
    var image: UIImage
    var memeImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memeImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memeImage = memeImage
    }
}