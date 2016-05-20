//
//  MemeEditorViewController.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/14/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

// protocol responsible for sending the edited meme back to the MemeDetailViewController
protocol MemeEditorProtocol {
    func finishToEdit(meme: Meme)
}

class MemeEditorViewController: UIViewController, FontViewProtocol {

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
    
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    
    var delegate: MemeEditorProtocol?
    
    // variable for image editing
    var imageToEdit: Meme?
    var memeIndex: Int!
    var isEditing: Bool! = false
    
    let Top_Message = "TOP"
    let Bottom_Message = "BOTTOM"
    
    // set text attributes
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
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        pickerDelegate = ImagePickerDelegate(view: imageView)
        topTextDelegate = TopTextFieldDelegate(screenView: view)
        bottomTextDelegate = BottomTextFieldDelegate(screenView: view)
        
        topTextField.delegate = topTextDelegate
        bottomTextField.delegate = bottomTextDelegate
        
        setupTextField(topTextField, withText: Top_Message)
        setupTextField(bottomTextField, withText: Bottom_Message)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // set the values of the meme that we want to edit
        if let temp = imageToEdit {
            imageView.image = UIImage(data: temp.originalImage)
            topTextField.text = temp.textTop
            bottomTextField.text = temp.textBottom
            isEditing = true
        }
    
        // camera button & share button availability
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = imageView.image != nil
        cancelButton.enabled = imageView.image != nil
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTextFields()
    }
    
    // set set the parameter of the view when the segue is executed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! FontViewController
        controller.delegate = self
    }
    
    // make this view controller to be full screen
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: -
    //MARK: protocol functions
    
    // set the font of the textfield after the user chooses it
    func fontSelected(font: String) {
        topTextField.font = UIFont(name: font, size: 40)
        bottomTextField.font = UIFont(name: font, size: 40)
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
        supportedInterfaceOrientations()
        
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
        
        if(isEditing == true) {
            imageToEdit?.textTop = topTextField.text!
            imageToEdit?.textBottom = bottomTextField.text!
            imageToEdit?.memeImage = UIImagePNGRepresentation(generated)
            delegate?.finishToEdit(imageToEdit!)
        } else {
        
        _ = Meme(top: topTextField.text!, bottom: bottomTextField.text!, original: imageView.image!, newimage: generated, context: temporaryContext)
        }
        
        CoreDataStackManager.sharedInstance().saveContext()
        
        
    }
    
    // reset textfield contraints to match image size
    private func layoutTextFields() {
        
        // remove any existing constraints
        if topConstraint != nil {
            view.removeConstraint(topConstraint)
        }
        
        if bottomConstraint != nil {
            view.removeConstraint(bottomConstraint)
        }
        
        // get the position of the image insie the imageView
        let size = imageView.image != nil ? imageView.image!.size : imageView.frame.size
        let frame = AVMakeRectWithAspectRatioInsideRect(size, imageView.bounds)
        
        // margin for the new constraints: 10% of the frame's height
        let margin = frame.origin.y + frame.size.height * 0.10
        
        // create and add the new constraints
        topConstraint = NSLayoutConstraint(item: topTextField, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Top, multiplier: 1.0, constant: margin)
        view.addConstraint(topConstraint)
        
        bottomConstraint = NSLayoutConstraint(item: bottomTextField, attribute: .Bottom, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1.0, constant: -margin)
        view.addConstraint(bottomConstraint)
    }
    
    
    
}

