//
//  LoginRequest.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/19/21.
//

import Foundation

struct LoginRequest: Codable {
    
    let username: String
    let password: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
        case requestToken = "request_token"
    }
}
