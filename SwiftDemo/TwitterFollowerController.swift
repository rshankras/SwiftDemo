//
//  TwitterFollowerController.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 15/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class TwitterFollowerController: UITableViewController, TwitterFollowerDelegate {
    
    var serviceWrapper: TwitterServiceWrapper = TwitterServiceWrapper()
    var followers = [TwitterFollower]()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceWrapper.delegate = self
        
        activityIndicator.startAnimating()
        
        serviceWrapper.getResponseForRequest("https://api.twitter.com/1.1/followers/list.json?screen_name=rshankra&skip_status=true&include_user_entities=false")
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
        let numberOfRows = followers.count
        return numberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        let follower = followers[indexPath.row] as TwitterFollower
        cell.imageView?.image = UIImage(data: follower.profileURL!)
        cell.textLabel?.text = follower.name
        
        return cell
    }
    
    // MARK: - TwitterFollowerDelegate methods
    
    func finishedDownloading(results: [TwitterFollower]) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.followers = results
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
        })
    }
    
}
