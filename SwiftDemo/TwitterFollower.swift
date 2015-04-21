//
//  TwitterFollowers.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 20/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import Foundation

struct TwitterFollower {
    var name: String?
    var description: String?
    var profileURL: NSData?
    
    init (name: String, url: String) {
        
        self.name = name
        let pictureURL = NSURL(string: url)
        profileURL = NSData(contentsOfURL: pictureURL!)
        
    }
}