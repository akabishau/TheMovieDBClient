//
//  LoginResponse.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/19/21.
//

import Foundation

struct LoginResponse: Codable {
    
    let success: Bool
    let expiresAt: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
