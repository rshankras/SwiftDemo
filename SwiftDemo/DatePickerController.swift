//
//  DatePickerController.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 17/06/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    
    @IBOutlet var datePicker:UIDatePicker!
    @IBOutlet var timePicker:UIDatePicker!
    @IBOutlet var dateTimeDisplay:UILabel!
    
    
    let dateFormatter = NSDateFormatter()
    let timeFormatter = NSDateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK:- DatePicker ValueChanged
    
    @IBAction func datePickerChanged(sender: AnyObject) {
        setDateAndTime()
    }
    
    @IBAction func timePickerChanged(sender: AnyObject) {
        setDateAndTime()
    }
    
    //MARK:- Date and time
    
    func setDateAndTime() {
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        timeFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        dateTimeDisplay.text = dateFormatter.stringFromDate(datePicker.date) + " " + timeFormatter.stringFromDate(timePicker.date)
    }
}
