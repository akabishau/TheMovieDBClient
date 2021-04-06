//
//  NetworkManager.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/31/21.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    private init() { }
    
    
    enum EndPoint {
        static var baseURL = "https://api.themoviedb.org/3"
        static var apiKeyParameter = "?api_key=\(AuthManager.api_key)"
        static var sessionIdParameter = "&session_id=\(AuthManager.shared.sessionId!)"
        
        case getFavoriteMovies
        
        
        var stringUrl: String {
            switch self {
            case .getFavoriteMovies:
                return "\(EndPoint.baseURL)/account/account_id=1/favorite/movies" + EndPoint.apiKeyParameter + EndPoint.sessionIdParameter //also available pagination + sort by created date
            }
        }
        
        var url: URL {
            return URL(string: stringUrl)!
        }
        
    }
    
    
    func getFavoriteMovies(completion: @escaping (Result<[Movie], TMDBError>) -> Void) {
        print(#function)
        
        let task = URLSession.shared.dataTask(with: EndPoint.getFavoriteMovies.url) { (data, response, error) in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let moviesResults = try JSONDecoder().decode(MovieResults.self, from: data)
                let movies = moviesResults.results
                completion(.success(movies))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
}
