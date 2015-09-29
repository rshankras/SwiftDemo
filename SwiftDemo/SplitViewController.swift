//
//  SplitViewController.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 06/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        return true;
    }
    
    override func showDetailViewController(vc: UIViewController, sender: AnyObject?) {
        if (vc.parentViewController is UINavigationController) {
            super.showDetailViewController(vc, sender: sender)
        }
        else {
            let nav = UINavigationController(rootViewController: vc)
            super.showDetailViewController(nav, sender: sender)
        }
    }

}
