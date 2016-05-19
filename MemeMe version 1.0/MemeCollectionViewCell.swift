//
//  MemeCollectionViewCell.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/19/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var meme: UIImageView!
    
    func setMemeImage(image: UIImage!) {
        meme.image = image
    }

}
