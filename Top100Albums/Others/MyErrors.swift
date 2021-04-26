//
//  MyErrors.swift
//  Top100Albums
//
//  Created by Surendra Singh on 4/24/21.
//

import Foundation
enum MyErrors:LocalizedError {
    case invalidValue
    
    var errorDescription: String?{
        switch self {
        case .invalidValue:
            return "You have invalid value"
        }
    }
}
