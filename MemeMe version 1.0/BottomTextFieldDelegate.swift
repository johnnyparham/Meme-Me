//
//  BottomTextFieldDelegate.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/15/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import UIKit

class BottomTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    // default values for the text field
    let bottomText = "BOTTOM"
    
    let container: UIView!
    
    init(screenView: UIView!) {
        container = screenView
    }
    
    
    // verify textfield has default text when user starts to edit
    
    func textFieldDidBeginEditing(textField: UITextField) {
        subscribeToKeyboardNotification()
        var currentText = textField.text
        
        if currentText == bottomText {
            currentText = ""
        }
        
        textField.text = currentText
    }
    
    // dismiss the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        unsubscribeFromKeyboardNotification()
        
        if textField.text == "" {
            textField.text = bottomText
        }
        
        return true
    }

    //MARK: -
    //MARK: Keyboard layout functions
    
    // change the size of the view to move up when the keyboard appears
    func keyboardWillShow(notification: NSNotification) {
        container.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    // change the size of the view to move down when the keyboard disappers
    func keyboardWillDismiss(notification: NSNotification) {
        container.frame.origin.y = 0
    }
    
    // get keyboard height from notification
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.CGRectValue().height
    }
    
    //MARK: -
    //MARK: Notification functions
    
    // add observer to notification center for keyboard
    private func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BottomTextFieldDelegate.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BottomTextFieldDelegate.keyboardWillDismiss(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // remove observer from notification center
    private func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
}
