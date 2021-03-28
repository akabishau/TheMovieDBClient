//
//  TabBarVC.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/27/21.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeVC()
        let favoritesListVC = FavoritesListVC()
        let watchListVC = WatchListVC()
        
        homeVC.title = "Home"
        favoritesListVC.title = "Favorites"
        watchListVC.title = "Watchlist"
        
        homeVC.view.backgroundColor = .systemBackground
        favoritesListVC.view.backgroundColor = .systemBackground
        watchListVC.view.backgroundColor = .systemBackground
        
        //TODO: add title options for nc and vc after final design sign off
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let favoritesListNC = UINavigationController(rootViewController: favoritesListVC)
        let watchListNC = UINavigationController(rootViewController: watchListVC)
        
        homeNC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        favoritesListNC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 1)
        watchListNC.tabBarItem = UITabBarItem(title: "Watchlist", image: UIImage(systemName: "list.and.film"), tag: 2)
        
        setViewControllers([homeNC, favoritesListNC, watchListNC], animated: true)
    }
}
