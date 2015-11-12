//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Daniele Vitali on 11/7/15.
//  Copyright © 2015 Daniele Vitali. All rights reserved.
//

import Foundation
import UIKit

class SentMemeTableViewController: SentMemeViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var memesTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memesTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("memeTableViewCell")! as! MemeTableViewCell
        let meme = memes[indexPath.row]
        
        cell.setMeme(meme)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showMeme(atIndex: indexPath.row)
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: { (tableViewRowAction, indexPath) in
            self.deleteMeme(indexPath.row)
            self.memesTableView.reloadData()
        })
        let editAction = UITableViewRowAction(style: .Default, title: "Edit", handler: { (tableViewRowAction, indexPath) in
            self.editMeme(atIndex: indexPath.row)
        })
        return [deleteAction, editAction]
    }
    
    func deleteMeme(index: Int) {
        memes.removeAtIndex(index)
    }
    
}