//
//  SearchView.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
    func didTappedSearchButton()
}

class SearchView: UIView {

    var delegate: SearchViewDelegate?
    
    private lazy var searchButton: IFButton = {
        let button = IFButton(title: "Search")
        button.addTarget(self, action: #selector(didTappedSearchButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchTextField: IFTextField = {
        let textFiled = IFTextField()
        return textFiled
    }()

    init(delegate: SearchViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.backgroundColor = .systemFill
        createSearchButton()
        createSearchTextField()
    }
    
    private func createSearchTextField() {
        addSubview(searchTextField)
        
        searchTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        searchTextField.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        searchTextField.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func createSearchButton() {
        addSubview(searchButton)
        
        searchButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    @objc private func didTappedSearchButton() {
        delegate?.didTappedSearchButton()
    }
        
}
