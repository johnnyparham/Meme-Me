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

class FontViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: FontViewProtocol?
    
    var content: [String] = ["Apple Color Emoji", "AppleSDGothicNeo-Regular", "Arial-BoldMT", "Baskerville", "ChalkboardSE-Regular", "Courier New", "Copperplate", "Damascus", "Farah", "Helvetica Neue", "HelveticaNeue-CondensedBlack", "Marker Felt", "Times New Roman"]
    
    //MARK: -
    //MARK: lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "itemContainer")
    }

  
    //MARK: -
    //MARK: table view delegate functions
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var line:UITableViewCell
        
        line = tableView.dequeueReusableCellWithIdentifier("itemContainer") as UITableViewCell!
        line.textLabel?.text = content[indexPath.row]
        
        return line
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let font = content[indexPath.row]
        delegate?.fontSelected(font)
        
        closeViewController()
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


}
