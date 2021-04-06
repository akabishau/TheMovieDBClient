//
//  TMDBError.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 4/5/21.
//

import Foundation

enum TMDBError: String, Error {
    case unableToComplete
    case invalidResponse
    case invalidData
}
