//
//  MemeTableViewCell.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/19/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var meme: UIImageView!
    
    func setContentWithText(text: String!, andImage image: UIImage!) {
        label.text = text
        meme.image = image  
    }

}
