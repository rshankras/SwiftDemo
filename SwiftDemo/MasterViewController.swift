//
//  MasterViewController.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 06/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var demoTypes = DemoType.getDemoTypes()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoTypes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = demoTypes[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.splitViewController?.showDetailViewController(getViewController(indexPath.row), sender: nil)
    }
    
    // MARK: - Demo Type
    
    func getControllerName(selectedRow: Int) -> String{
        
        var controllerName: String = "DetailViewController"
        
        switch (selectedRow) {
        case DemoType.TextField.rawValue:
            controllerName = "TextFieldDemoController"
        case DemoType.Slider.rawValue:
            controllerName = "SliderDemoController"
        case DemoType.Sound.rawValue:
            controllerName = "SoundController"
        case DemoType.TwitterFollower.rawValue:
            controllerName = "TwitterFollowerController"
        default:
            break;
        }
        
        return controllerName
    }
    
    func getViewController(selectedRow: Int) -> UIViewController {
        
        let controllerName = getControllerName(selectedRow)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier(controllerName) as! UIViewController
        
        return viewController
    }
}
