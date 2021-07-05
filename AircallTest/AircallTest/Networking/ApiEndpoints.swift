//
//  ApiEndpoints.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

public enum ApiEndpoints {
    case activities
    case activity(id: String)
    case reset
}

extension ApiEndpoints {
    var path: String {
        switch self {
        case .activities:
            return "/activities"
        case .activity(id: let id):
            return "/activities/\(id)"
        case .reset:
            return "/reset"
        }
    }
    
    var mockFilename: String {
        switch self {
        case .activities:
            return "MockActivities"
        case .activity(id: _):
            return ""
        case .reset:
            return ""
        }
    }
}
