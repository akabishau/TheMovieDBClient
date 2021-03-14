//
//  SessionRequest.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/14/21.
//

import Foundation

struct SessionRequest: Codable {
    
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}
