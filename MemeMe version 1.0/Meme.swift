//
//  Meme.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/14/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Meme: NSManagedObject {
    
    @NSManaged var textTop: String!
    @NSManaged var textBottom: String!
    @NSManaged var originalImage: NSData!
    @NSManaged var memeImage: NSData!
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(top: String, bottom: String, original: UIImage, newimage: UIImage, context: NSManagedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Meme", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        textTop = top
        textBottom = bottom
        originalImage = UIImagePNGRepresentation(original)
        memeImage = UIImagePNGRepresentation(newimage)
    }

}
