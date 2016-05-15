//
//  TopTextFieldDelegate.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/15/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import UIKit

class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // default values for the text fields
    let topText = "TOP"
    
    // verify if textfield has default text when the user edits the text
    func textFieldDidBeginEditing(textField: UITextField) {
        
        var currentText = textField.text
        
        if currentText == topText {
            currentText = ""
        }
        
        textField.text = currentText
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField.text == "" {
            textField.text = topText
        }
        
        return true
    }

}
