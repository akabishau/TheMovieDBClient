//
//  MDBButton.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/15/21.
//

import UIKit

class MDBButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    convenience init(title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        layer.cornerRadius = 10
        setTitleColor(.black, for: .normal)
    }
}
