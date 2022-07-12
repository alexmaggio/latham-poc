//
//  Int+SizeUnit.swift
//  BrightUploaderPOC
//
//  Created by Alex Maggio on 12/07/2022.
//

import Foundation

extension Int {
    private enum units {
        case kb
        case mb
        case gb
        
        var value: Int {
            switch self {
            case .kb: return 1024
            case .mb: return 1024 * units.kb.value
            case .gb: return 1024 * units.mb.value
            }
        }
    }
    var kb: Int {
        self * units.kb.value
    }
    
    var mb: Int {
        self * units.mb.value
    }
    
    var gb: Int {
        self * units.gb.value
    }
}
