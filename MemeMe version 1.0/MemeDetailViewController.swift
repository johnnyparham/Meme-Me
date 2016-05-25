//
//  MemeDetailViewController.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/19/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MemeDetailViewController: UIViewController, MemeEditorProtocol {
    
    var meme: Meme!
    var index: Int!
    
    @IBOutlet weak var memeDetailed: UIImageView!
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    // MARK: -
    // MARK: lifecycle functions
    
    override func viewWillAppear(animated: Bool) {
                super.viewWillAppear(animated)
        
        memeDetailed.image = UIImage(data: meme.memeImage)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editSegue" {
            
            let controller = segue.destinationViewController as! MemeEditorViewController
            
            controller.memeIndex = index
            controller.imageToEdit = meme
            controller.delegate = self
            
        }
    }
    
    
    // MARK: -
    // MARK: action functions
    
    @IBAction func deleteMemeImage(sender: AnyObject) {
        sharedContext.deleteObject(meme)
        CoreDataStackManager.sharedInstance().saveContext()
        
        navigationController!.popViewControllerAnimated(true)
        
    
    }

    
    // MARK: -
    // MARK: delegate
    
    func finishToEdit(meme: Meme) {
        self.meme = meme
    }
}


