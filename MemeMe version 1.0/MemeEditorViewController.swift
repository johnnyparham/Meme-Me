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
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    var pickerDelegate: ImagePickerDelegate!
    var topTextDelegate: TopTextFieldDelegate!
    var bottomTextDelegate: BottomTextFieldDelegate!
    
    
    // variable for image editing
    var imageToEdit: Meme?
    var isEditing : Bool! = false
    
    let Top_Message = "Top"
    let Bottom_Message = "Bottom"
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -1.0
    ]
    
    lazy var temporaryContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.contentMode = .ScaleAspectFit
        
        pickerDelegate = ImagePickerDelegate(view: imageView)
        topTextDelegate = TopTextFieldDelegate()
        bottomTextDelegate = BottomTextFieldDelegate(screenView: view)
        
        topTextField.delegate = topTextDelegate
        bottomTextField.delegate = bottomTextDelegate
        
        setupTextField(topTextField, withText: Top_Message)
        setupTextField(bottomTextField, withText: Bottom_Message)
        
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    
        // camera button & share button availability
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = imageView.image != nil
        cancelButton.enabled = imageView.image != nil
        
        
    
    }
    
    // make this view controller to be full screen
    override func prefersStatusBarHidden() -> Bool {
        return true
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
        let generated = generateMeme()
        
        let nextController = UIActivityViewController(activityItems: [generated], applicationActivities: nil)
        nextController.completionWithItemsHandler = { activity, success, items, error in
            
            if(success) {
                self.saveMeme(generated)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(nextController, animated: true, completion: nil)
    }
    
    
    
    // reset UI
    @IBAction func resetUI(sender: UIBarButtonItem) {
        setupTextField(topTextField, withText: Top_Message)
        setupTextField(bottomTextField, withText: Bottom_Message)
        imageView.image = nil
        shareButton.enabled = false
        
        dismissViewControllerAnimated(true, completion: nil)
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
    
    // generate meme image
    private func generateMeme() -> UIImage {
        setToolbarHidden(true)
        
        UIGraphicsBeginImageContext(view.frame.size)
        
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        
        let generatedImage : UIImage!
        generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        setToolbarHidden(false)
        
        return generatedImage
    }
    
    // hide toolbars
    private func setToolbarHidden(isHidden: Bool) {
        topToolBar.hidden = isHidden
        bottomToolBar.hidden = isHidden
    }
    
    // create meme object
    private func saveMeme(generated: UIImage) {
        _ = Meme(top: topTextField.text!, bottom: bottomTextField.text!, original: imageView.image!, newimage: generated, context: temporaryContext)
    }
    
    
    
    
    
}

