//
//  MDBTextField.swift
//  TheMovieDBClient
//
//  Created by Aleksey Kabishau on 3/14/21.
//

import UIKit

class MDBTextField: UITextField {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.backgroundColor = UIColor.systemBackground.cgColor
        
        textColor = .label // black in light mode and white in black mode
        tintColor = .label // blinking cursor
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        
        autocorrectionType = .no
        returnKeyType = .next
        
        //placeholder = "Enter a username"
    }
}
