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
        static let accountId = 1
    }
    
    
    enum EndPoints{
        static let baseURL = "https://api.themoviedb.org/3"
        static let apiKeyParameter = "?api_key=\(Constants.api_key)"
        static let sessionIdParameter = "&session_id=\(AuthManager.shared.sessionId!)"
        
        case getRequestToken
        case createSession
        case webAuth
        case login
        case getFavorites
        
        
        var stringUrl: String {
            switch self {
            case .getRequestToken:
                return EndPoints.baseURL + "/authentication/token/new" + EndPoints.apiKeyParameter
            case .createSession:
                return EndPoints.baseURL + "/authentication/session/new" + EndPoints.apiKeyParameter
            case .webAuth:
                return "https://www.themoviedb.org/authenticate/\(AuthManager.shared.accessToken!)?redirect_to=themoviedbclient:authenticate"
            case .login:
                return "https://api.themoviedb.org/3/authentication/token/validate_with_login" + EndPoints.apiKeyParameter
            case .getFavorites:
                return "\(EndPoints.baseURL)/account/\(Constants.accountId)/favorite/movies" + EndPoints.apiKeyParameter + EndPoints.sessionIdParameter //also available pagination + sort by created date
            }
        }
        
        var url: URL {
            return URL(string: stringUrl)!
        }
    }
    
    
    var isSignedIn: Bool {
        return sessionId != nil
    }
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    //TODO: - Review the documentation about expiration date and how to review it before it expires
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expiration_date") as? Date
    }
    
    var sessionId: String? {
        return UserDefaults.standard.string(forKey: "session_id")
    }
    
    
    private func cacheToken(from response: TokenResponse) {
        UserDefaults.standard.setValue(response.requestToken, forKey: "access_token")
        UserDefaults.standard.setValue(response.expiresAt, forKey: "expiration_date")
    }
    
    private func cacheSessionId(from response: SessionResponse) {
        UserDefaults.standard.setValue(response.sessionId, forKey: "session_id")
    }
    
    
    func getRequestToken(completion: @escaping (Bool) -> Void) {
        print(#function)
        let task = URLSession.shared.dataTask(with: EndPoints.getRequestToken.url) { (data, response, error) in
            //TODO: -  check response -> different json structure
            guard let data = data, error == nil else {
                completion(false)
                print("error receiving token")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TokenResponse.self, from: data)
                print(response)
                self.cacheToken(from: response)
                completion(true)
            } catch {
                print("Error parsing Token: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    
    func createSession(completion: @escaping (Bool) -> Void) {
        print(#function)
        
        var request = URLRequest(url: EndPoints.createSession.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let accessToken = accessToken else {
            print("no access token available")
            completion(false)
            return
        }
        request.httpBody = try! JSONEncoder().encode(SessionRequest(requestToken: accessToken))
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error creating session")
                completion(false)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(SessionResponse.self, from: data)
                print(response)
                self.cacheSessionId(from: response)
                completion(true)
            } catch {
                print("Error parsing Session response: \(error.localizedDescription)")
                completion(false)
            }
            
        }
        task.resume()
        
    }
    
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let accessToken = accessToken else {
            print("no access token available")
            completion(false)
            return
        }
        
        request.httpBody = try! JSONEncoder().encode(LoginRequest(username: username, password: password, requestToken: accessToken))
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("login datatask error: \(error!.localizedDescription)")
                completion(false)
                return
            }
            print(data)
            do {
                let response = try JSONDecoder().decode(TokenResponse.self, from: data)
                print(response)
                self.cacheToken(from: response)
                completion(true)
            } catch {
                print("Error parsing Login response: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
    
    
    func getFavoritesMovies(completion: @escaping ([Movie]?) -> Void) {
        print(#function)
        
        let task = URLSession.shared.dataTask(with: EndPoints.getFavorites.url) { data, response, error in
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
