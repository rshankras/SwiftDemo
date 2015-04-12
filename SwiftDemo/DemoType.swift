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
    
    static let allValues = [TextField, Slider, Sound]
    
    func getDisplayName(type:DemoType) -> String {
        
        var dispayName:String = "Demo"
        
        switch (type) {
        case .TextField:
            dispayName = "TextField"
        case .Slider:
            dispayName = "Slider"
        case .Sound:
            dispayName = "Record and Play Sound"
        default:
            break;
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