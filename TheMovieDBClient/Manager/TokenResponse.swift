//
//  TokenResponse.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/11/21.
//

import Foundation


struct TokenResponse: Codable {
    
    let success: Bool
    let expiresAt: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
