//
//  Movie.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/27/21.
//

import Foundation

struct Movie: Codable {
    
    let adult: Bool
    let title: String
    let id: Int
    let rating: Double
    let posterImage: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case title = "original_title"
        case id
        case rating = "vote_average"
        case posterImage = "poster_path"
    }
}
