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
    
    
    func getFavoritesMovies(completion: @escaping ([Movie]?) -> Void) {
        print(#function)
        
        let task = URLSession.shared.dataTask(with: EndPoint.getFavoriteMovies.url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error requesting Favorites: \(error?.localizedDescription ?? "")")
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieResults.self, from: data)
                let movies = response.results
                completion(movies)
            } catch {
                print("Error parsing Favorite Movies response: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}
