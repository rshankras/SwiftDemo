//
//  DemoType.swift
//  SwiftDemo
//
//  Created by Ravi Shankar on 06/04/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import Foundation

enum DemoType: Int {
    case TextField = 0
    case Slider
    case Sound
    case TwitterFollower
    case DatePicker
    case ProgressView
    
    static let allValues = [TextField, Slider, Sound, TwitterFollower, DatePicker, ProgressView]
    
    func getDisplayName(type:DemoType) -> String {
        
        var dispayName:String = "Demo"
        
        switch (type) {
        case .TextField:
            dispayName = "TextField"
        case .Slider:
            dispayName = "Slider"
        case .Sound:
            dispayName = "Record and Play Sound"
        case .TwitterFollower:
            dispayName = "Twitter Followers"
        case .DatePicker:
            dispayName = "DatePicker"
        case .ProgressView:
            dispayName = "ProgressView"
        }
        return dispayName
    }
    
 static func getDemoTypes() -> [String] {
    var types:[String] = []
        
        for type in DemoType.allValues {
            types.append(type.getDisplayName(type))
        }
        return types
    }

}