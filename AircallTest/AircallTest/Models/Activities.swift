//
//  Activities.swift
//  AircallTest
//
//  Created by Maxence Chantôme on 05/07/2021.
//

import Foundation

typealias Activities = [Activity]

// MARK: - Activity
struct Activity: Codable, Identifiable {
    let id: Int
    let createdAt: Date
    let direction: Direction
    let from: String
    let to: String?
    let via, duration: String
    let isArchived: Bool
    let callType: CallType

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case direction
        case from
        case to
        case via
        case duration
        case isArchived = "is_archived"
        case callType = "call_type"
    }
    
    enum Direction: String, Codable {
        case inbound, outbound
    }
    
    enum CallType: String, Codable {
        case missed, answered, voicemail
    }
}

