//
//  ViewController.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/8/21.
//

import UIKit

class AuthVC: UIViewController {
    
    let usernameTextField = MDBTextField(placeholder: "Username")
    let passwordTextField = MDBTextField(placeholder: "Password")
    let loginButton = MDBButton(title: "Login")
    let loginViaWebButton = MDBButton(title: "Login via Website")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        configureUI()
        
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        loginViaWebButton.addTarget(self, action: #selector(didTapLoginViaWeb), for: .touchUpInside)
    }
    
    
    @objc private func didTapLogin() {
        print(#function)
        AuthManager.shared.getRequestToken { success in
            if success {
                print("Request Token: \(AuthManager.Constants.requestToken)")
                //TODO: - Get user input and handle errors
                AuthManager.shared.login(username: "kabishauTest", password: "kabishauTest") { success in
                    if success {
                        print("Request Token Confirmation: \(AuthManager.Constants.requestToken)")
                        AuthManager.shared.createSession { success in
                            print("Session ID: \(AuthManager.Constants.sessionId)")
                            AuthManager.shared.getFavoritesMovies { favorites in
                                guard let favorites = favorites else {
                                    print("User has no favorites")
                                    return
                                }
                                for movie in favorites {
                                    print(movie.title)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @objc private func didTapLoginViaWeb() {
        print(#function)
        AuthManager.shared.getRequestToken { (success) in
            if success {
                print("Token: \(AuthManager.Constants.requestToken)")
                DispatchQueue.main.async {
                    print("going to call open function")
                    UIApplication.shared.open(AuthManager.EndPoints.webAuth.url, options: [:], completionHandler: nil)
                }
            } else {
                print("WelcomeVC: Error Trying to get Token")
            }
        }
    }
    
    
    private func configureUI() {
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(loginViaWebButton)
        
        //passwordTextField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            loginViaWebButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginViaWebButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginViaWebButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            loginViaWebButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

