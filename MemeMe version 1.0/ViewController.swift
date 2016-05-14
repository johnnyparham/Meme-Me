//
//  ViewController.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/14/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: -
    //MARK: Action functions
    
    
    // open the image picker controller from the library
    @IBAction func pickImageFromLibrary(sender: UIBarButtonItem) {
        
    }
    
    // open the image picker controller from the camera
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        
    }
    
    // share the created meme image
    @IBAction func shareMemeImage(sender: UIBarButtonItem) {
        
    }
    
    
    // reset UI
    @IBAction func resetUI(sender: UIBarButtonItem) {
        
    }

}

