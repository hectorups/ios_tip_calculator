//
//  Date.swift
//  TipCalculator
//
//  Created by Hector Monserrate on 15/08/14.
//  Copyright (c) 2014 Hector Monserrate. All rights reserved.
//

import Foundation

extension Int {
    var minutes: NSTimeInterval {
        let MINUTE_IN_SECONDS = 60
            var minute:Double = Double(MINUTE_IN_SECONDS) * Double(self)
            return minute
    }
}
