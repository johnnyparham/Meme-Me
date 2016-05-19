//
//  FontViewController.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/18/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import UIKit
import Foundation

// protocol responsible for communication with the ViewController that calls the FontViewController
protocol FontViewProtocol {
    func fontSelected(font: String)
}

class FontViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: FontViewProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -
    //MARK: action functions
    
    @IBAction func done(sender: AnyObject) {
        closeViewController()
    }
    
    //MARK: -
    //MARK: private functions
    
    private func closeViewController() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
