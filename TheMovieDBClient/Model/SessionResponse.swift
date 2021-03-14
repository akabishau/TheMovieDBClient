//
//  SessionResponse.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/14/21.
//

import Foundation

struct SessionResponse: Codable {
    
    let success: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}
