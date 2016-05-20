//
//  SentMemesCollectionViewController.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/19/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!
    
    // MARK: -
    // MARK: lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2*space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        memes = fetchAllMemes()
        collectionView!.reloadData()
    }
    
    // MARK: -
    // MARK: core data context
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    private func fetchAllMemes() -> [Meme] {
        do {
            let request = NSFetchRequest(entityName: "Meme")
            return try sharedContext.executeFetchRequest(request) as! [Meme]
        } catch let error as NSError {
            print("Error to fetch all memes! \(error)")
            return [Meme]()
        }
    }


    // MARK: -
    // MARK: collection view delegate functions

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let memeImage = UIImage(data: memes[indexPath.item].memeImage)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("itemCollectionContainer", forIndexPath: indexPath) as! MemeCollectionViewCell
        cell.setMemeImage(memeImage)
    
        return cell
    }


    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetail =
        storyboard!.instantiateViewControllerWithIdentifier("MemeDetailView")
        as! MemeDetailViewController
        
        memeDetail.meme = memes[indexPath.item]
        memeDetail.index = indexPath.item
        
        navigationController!.pushViewController(memeDetail, animated: true)
    }

}
