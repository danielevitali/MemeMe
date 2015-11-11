//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Daniele Vitali on 11/7/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: SentMemeViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var memesCollection: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        calculateLayoutFlow(withWidth: view.frame.size.width, withHeight: view.frame.size.height)
        memesCollection.reloadData()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        calculateLayoutFlow(withWidth: size.width, withHeight: size.height)
    }
    
    private func calculateLayoutFlow(withWidth viewWidth: CGFloat, withHeight viewHeight: CGFloat) {
        let space: CGFloat = 3.0
        var dimension: CGFloat
        
        if viewWidth < viewHeight {
            dimension = (viewWidth - (2 * space)) / 3.0
        } else {
            dimension = (viewWidth - (4 * space)) / 5.0
        }
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        cell.setMeme(meme)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedMeme = memes[indexPath.row]
        performSegueWithIdentifier("openMemeSegue", sender: self)
    }
    
}