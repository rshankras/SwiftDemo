//
//  ProgressViewController.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 24/06/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    var progressView: UIProgressView?
    var progressLabel: UILabel?
    
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addControls()
        addGestures()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Controls
    
    func addControls() {
        
        // Create Progress View Control
        
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        progressView?.center = self.view.center
        
        view.addSubview(progressView!)
        
        // Add Label
        
        progressLabel = UILabel()
        let frame = CGRectMake(view.center.x - 25, view.center.y - 100, 100, 50)
        progressLabel?.frame = frame
        
        view.addSubview(progressLabel!)
        
    }
    
    //MARK:- Gestures
    
    func addGestures() {
        
        // Add Single Tap and Doube Tap Gestures
        
        let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        tap.numberOfTapsRequired = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        doubleTap.numberOfTapsRequired = 2
        
        view.addGestureRecognizer(tap)
        view.addGestureRecognizer(doubleTap)
        tap.requireGestureRecognizerToFail(doubleTap)
        
    }
    
    //MARK:- Single Tap
    
    // Start Progress View
    
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateProgress", userInfo: nil, repeats: true)
        }
    }
    
    //MARK:- Double Tap
    
    // Reset Progress View
    
    func handleDoubleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            progressView?.progress = 0.0
            progressLabel?.text = "0 %"
            timer?.invalidate()
        }
    }
    
    //MARK:- Increment Progress
    
    func updateProgress() {
        progressView?.progress += 0.05
        
        let progressValue = self.progressView?.progress
        progressLabel?.text = "\(progressValue! * 100) %"
    }
    
}
