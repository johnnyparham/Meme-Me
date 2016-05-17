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
    
    let container: UIView!
    
    init(screenView: UIView!) {
        container = screenView
    }
    
    // verify if textfield has default text when the user edits the text
    func textFieldDidBeginEditing(textField: UITextField) {
        subscribeToKeyboardNotification()
        
        var currentText = textField.text
        
        if currentText == topText {
            currentText = ""
        }
        
        textField.text = currentText
    }
    
    // keep view in place when the keyboard appears
    func viewWillShow(notification: NSNotification) {
        container.frame.origin.y =  0
    }
    
    // keep view in place when keyboard disappears
    func keyboardWillDismiss(notificaion: NSNotification) {
        container.frame.origin.y = 0
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        unsubscribeFromKeyboardNotification()
        
        if textField.text == "" {
            textField.text = topText
        }
        
        return true
    }
    
    
    //MARK: -
    //MARK: notification functions
    
    // add observer to the notification center so we can discover when the keyboard is showing
    
    private func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TopTextFieldDelegate.viewWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TopTextFieldDelegate.keyboardWillDismiss(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // remove observer from the notification center
    
    private func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

}
