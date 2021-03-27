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
        case createSession
        case webAuth
        case login
        
        
        var stringUrl: String {
            switch self {
            case .getRequestToken:
                return EndPoints.baseURL + "/authentication/token/new" + EndPoints.apiKeyParameter
            case .createSession:
                return EndPoints.baseURL + "/authentication/session/new" + EndPoints.apiKeyParameter
            case .webAuth:
                return "https://www.themoviedb.org/authenticate/\(Constants.requestToken)?redirect_to=themoviedbclient:authenticate"
            case .login:
                return "https://api.themoviedb.org/3/authentication/token/validate_with_login" + EndPoints.apiKeyParameter
            }
        }
        
        var url: URL {
            return URL(string: stringUrl)!
        }
    }
    
    
    class func getRequestToken(completion: @escaping (Bool) -> Void) {
        print(#function)
        let task = URLSession.shared.dataTask(with: EndPoints.getRequestToken.url) { (data, response, error) in
            // check response -> different json structure
            guard let data = data, error == nil else {
                completion(false)
                print("error receiving token")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TokenResponse.self, from: data)
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
    
    
    class func createSession(completion: @escaping (Bool) -> Void) {
        print(#function)
        
        var request = URLRequest(url: EndPoints.createSession.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(SessionRequest(requestToken: Constants.requestToken))
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error creating session")
                completion(false)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(SessionResponse.self, from: data)
                print(response)
                Constants.sessionId = response.sessionId
                completion(true)
            } catch {
                print("Error parsing Session response: \(error.localizedDescription)")
                completion(false)
            }
            
        }
        task.resume()
        
    }
    
    
    class func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        print(#function)
        var request = URLRequest(url: EndPoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(LoginRequest(username: username, password: password, requestToken: Constants.requestToken))
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("login datatask error: \(error!.localizedDescription)")
                completion(false)
                return
            }
            print(data)
            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                print(response)
                // capture expiration - handle later
                Constants.requestToken = response.requestToken
                completion(true)
            } catch {
                print("Error parsing Login response: \(error.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
    }
}
