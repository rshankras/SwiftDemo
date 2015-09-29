//
//  TextFieldDemoController.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 06/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class TextFieldDemoController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var rateTextField: UITextField!
    
    @IBOutlet weak var interestLabel: UILabel!
    
    var textFields:[UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.amountTextField.delegate = self
        self.rateTextField.delegate = self
        
        textFields = [amountTextField, rateTextField]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK :- TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        var currentTextField = textFields[0]
        
        if (currentTextField == textField) {
            currentTextField = textFields[1]
            currentTextField.becomeFirstResponder()
        } else {
            currentTextField.resignFirstResponder()
            interestLabel.text  = "\(calculateInterest())"
        }
        
        return true
    }
    
    //MARK :- Calculation
    
    func calculateInterest() -> Double {
        let amount: Double =  Double(amountTextField.text!)!
        let rate:Double = Double(rateTextField.text!)!
        
        return amount * rate
    }
}
