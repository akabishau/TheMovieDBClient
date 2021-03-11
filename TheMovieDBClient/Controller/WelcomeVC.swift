//
//  ViewController.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/8/21.
//

import UIKit

class WelcomeVC: UIViewController {
    
    let signInButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        configureSignInButton()
    
    }
    
    
    @objc private func didTapSignIn() {
        print(#function)
    }
    
    
    private func configureSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.backgroundColor = .white
        signInButton.setTitle("Sign in to TMDB", for: .normal)
        signInButton.setTitleColor(.black, for: .normal)
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

