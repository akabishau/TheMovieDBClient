//
//  ViewController.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/8/21.
//

import UIKit

class WelcomeVC: UIViewController {
    
    let signInViaWebButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        configureSignInButton()
    
    }
    
    
    @objc private func didTapSignIn() {
        print(#function)
        AuthManager.getRequestToken { (success) in
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
    
    
    private func configureSignInButton() {
        view.addSubview(signInViaWebButton)
        
        signInViaWebButton.translatesAutoresizingMaskIntoConstraints = false
        signInViaWebButton.backgroundColor = .white
        signInViaWebButton.setTitle("Sign in via Website", for: .normal)
        signInViaWebButton.setTitleColor(.black, for: .normal)
        signInViaWebButton.layer.cornerRadius = 10
        signInViaWebButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signInViaWebButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInViaWebButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signInViaWebButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            signInViaWebButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

