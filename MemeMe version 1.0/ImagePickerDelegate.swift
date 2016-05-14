//
//  ImagePickerDelegate.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/14/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import UIKit

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imageHolder: UIImageView!
    
    init(view: UIImageView!) {
        imageHolder = view
    }
    
    // get selected picture
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageHolder.image = image
        dismiss(picker)
    }
    
    // cancel the picker
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(picker)
    }
    
    // dismiss the controller
    private func dismiss(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}




