//
//  MemeEditorViewController.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/14/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit
import CoreData



class MemeEditorViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    var pickerDelegate: ImagePickerDelegate!
    
    
    // variable for image editing
    var imageToEdit: Meme?
    var isEditing : Bool! = false
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -1.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .ScaleAspectFit
        
        pickerDelegate = ImagePickerDelegate(view: imageView)
        
        let Top_Message = "Top"
        let Bottom_Message = "Bottom"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    
        // camera button & share button availability
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = imageView.image != nil
        
        // prepare image for meme
        if let temp = imageToEdit {
            imageView.image = UIImage(data: temp.originalImage)
            topTextField.text = temp.textTop
            bottomTextField.text = temp.textBottom
            isEditing = true
        }
    
    }
    
 
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: -
    //MARK: Action functions
    
    
    // open the image picker controller from the library
    @IBAction func pickImageFromLibrary(sender: UIBarButtonItem) {
        pickImage(ofType: UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    // open the image picker controller from the camera
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        pickImage(ofType: UIImagePickerControllerSourceType.Camera)
    }
    
    // share the created meme image
    @IBAction func shareMemeImage(sender: UIBarButtonItem) {
        
    }
    
    
    // reset UI
    @IBAction func resetUI(sender: UIBarButtonItem) {
        
    }

    //MARK: -
    //MARK: Helper Fuctions
    
    // open the picker with the desired source type
    private func pickImage(ofType type: UIImagePickerControllerSourceType!) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = pickerDelegate
        pickerController.sourceType = type
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    // setup text fields
    private func setupTextField(field: UITextField, withText text: String!) {
        field.text = text
        field.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        field.defaultTextAttributes = memeTextAttributes
        field.textAlignment = NSTextAlignment.Center
    }
    
    
    
    
}

