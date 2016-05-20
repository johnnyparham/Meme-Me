
//  SentMemesTableViewController.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/19/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.


import Foundation
import UIKit
import CoreData 

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme]!

    // MARK: -
    // MARK: lifecycle functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = fetchAllMemes()
        tableView!.reloadData()
    }
    
    // MARK: -
    // MARK: core data context
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    // MARK: -
    // MARK: private functions
    
    private func fetchAllMemes() -> [Meme] {
        
        do {
            let request = NSFetchRequest(entityName: "Meme")
            return try sharedContext.executeFetchRequest(request) as! [Meme]
        } catch let error as NSError {
            print("Error to fetch all memes! \(error)")
            return [Meme]()
        }
    }

    // MARK: - table view delegate functions

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var line:MemeTableViewCell!
        
        let text = memes[indexPath.row].textTop + " " + memes[indexPath.row].textBottom
        let memeImage = UIImage(data: memes[indexPath.row].memeImage)
        
        line = tableView.dequeueReusableCellWithIdentifier("itemTableContainer") as! MemeTableViewCell
        line.setContentWithText(text, andImage: memeImage)

        return line
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let memeDetail =
        storyboard!.instantiateViewControllerWithIdentifier("MemeDetailView")
        as! MemeDetailViewController
        
        memeDetail.meme = memes[indexPath.row]
        memeDetail.index = indexPath.row
        
        navigationController!.pushViewController(memeDetail, animated: true)
    }
    
    


}
