//
//  Utility.swift
//  PureCast
//
//  Created by Garrett Votaw on 11/11/20.
//  Copyright © 2020 Garrett Votaw. All rights reserved.
//

import Foundation

class Utility: NSObject {
    
    private static var timeMSFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    private static var timeHMSFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    
    static func formatSecondsToHMS(_ seconds: Double) -> String {
        var text = "00.00"
        guard !seconds.isNaN else {
            return text
        }
        
        if seconds < 3600 {
            text = timeMSFormatter.string(from: seconds) ?? "00.00"
        } else {
            text = timeHMSFormatter.string(from: seconds) ?? "00.00"
        }
         
        return text
    }
    
}
