//
//  AuthManager.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/10/21.
//

import Foundation

class AuthManager {
    
    static let shared = AuthManager()
    private init() { }
    
    
    struct Constants {
        static let api_key = "64220f6c5aefcbcea6bded475e131e43"
        
        static var requestToken = ""
        static var sessionId = ""
        
    }
    
    
    enum EndPoints{
        static let baseURL = "https://api.themoviedb.org/3"
        static let apiKeyParameter = "?api_key=\(Constants.api_key)"
        
        case getRequestToken
        
        
        var stringUrl: String {
            switch self {
            case .getRequestToken:
                return EndPoints.baseURL + "/authentication/token/new" + EndPoints.apiKeyParameter
            }
        }
        
        var url: URL {
            return URL(string: stringUrl)!
        }
    }
    
    
    class func getRequestToken(completion: @escaping (Bool) -> Void) {
        
        let task = URLSession.shared.dataTask(with: EndPoints.getRequestToken.url) { (data, response, error) in
            // check response -> different json structure
            guard let data = data, error == nil else {
                completion(false)
                print("error receiving token")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TokenResponse.self, from: data)
                print(response)
                //TODO: - cache the token user defaults
                Constants.requestToken = response.requestToken
                completion(true)
            } catch {
                print("Error parsing Token: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
}
