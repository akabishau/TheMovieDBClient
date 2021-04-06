//
//  FavoritesListVC.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/27/21.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    var favoriteMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()        
        
        NetworkManager.shared.getFavoriteMovies { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.favoriteMovies.append(contentsOf: movies)
                // handle no favorite movies case
                self.favoriteMovies.forEach { print($0.title)}
            case .failure(let error):
                //TODO: - present alert with error description in main thread
                print("Error: \(error)")
            }
        }
    }
}
