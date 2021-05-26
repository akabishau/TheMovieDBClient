//
//  FavoritesListVC.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/27/21.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    var tableView: UITableView!
    
    var favoriteMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()        
        
        configureTableView()
        
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
    
    
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


extension FavoritesListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = favoriteMovies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    
}


extension FavoritesListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(favoriteMovies[indexPath.row].title)
    }
}

