//
//  FavoritesListVC.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/27/21.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
