//
//  SwitchDemoController.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 07/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

class SliderDemoController: UIViewController {

    @IBOutlet weak var redSliderValue: UILabel!
    @IBOutlet weak var blueSliderValue: UILabel!
    @IBOutlet weak var greenSliderValue: UILabel!
    
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var demoView: UIView!
    
    var sliders:[UISlider] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliders = [redSlider,blueSlider,greenSlider]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Update Colour
    
    @IBAction func updateColour(sender: UISlider) {
        
        var red:Float = redSlider.value
        var blue:Float = blueSlider.value
        var green:Float = greenSlider.value
        
        if (sender == sliders[0]) {
            red = Float(sender.value)
            redSliderValue.text = "\(sender.value)"
        } else if (sender == sliders[1]) {
            blue = Float(sender.value)
            blueSliderValue.text = "\(sender.value)"
        } else {
            green = Float(sender.value)
            greenSliderValue.text = "\(sender.value)"
        }
        
        var color: UIColor = UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(1.0))
        
        demoView.backgroundColor = color
    }
}
