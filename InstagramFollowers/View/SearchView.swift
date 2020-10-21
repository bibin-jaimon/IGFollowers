//
//  SearchView.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
    func didTappedSearchButton(for searchTerm: String)
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
        textFiled.placeholder = "Enter username"
        textFiled.delegate = self
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
        self.backgroundColor = .systemGray6
        hideKeyboardWhenTappedAround()
        
        addSubviews(
            searchTextField,
            searchButton
        )
        
        configureSearchButton()
        configureSearchTextField()
    }
    
    
    private func configureSearchTextField() {
        NSLayoutConstraint.activate([
            searchTextField.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            searchTextField.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            searchTextField.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            searchTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    @objc private func didTappedSearchButton() {
//        self.searchTextField.text = "SAllen0400"
        guard let searchTerm = self.searchTextField.text else {
            return
        }
        delegate?.didTappedSearchButton(for: searchTerm)
    }
        
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
