//
//  Currency.swift
//  TipCalculator
//
//  Created by Hector Monserrate on 14/08/14.
//  Copyright (c) 2014 Hector Monserrate. All rights reserved.
//

import Foundation

enum Currency: Int {
    case Dollar = 0, Euro, Pound, Yen
    
    static let allValues = [Dollar, Euro, Pound, Yen]
    
    func shortVersion() -> String {
        switch self {
        case .Dollar:
            return "$"
        case .Euro:
            return "€"
        case .Pound:
            return "£"
        case .Yen:
            return "¥"
        }
    }
    
    func longVersion() -> String {
        switch self {
        case .Dollar:
            return "Dollar"
        case .Euro:
            return "Euro"
        case .Pound:
            return "Pound"
        case .Yen:
            return "Yen"
        }
    }
}
