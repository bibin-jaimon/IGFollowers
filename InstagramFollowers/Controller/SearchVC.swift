//
//  SearchVC.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    private var searchView: SearchView!
    
    override func loadView() {
        searchView = SearchView(delegate: self)
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
    }
    
    
    
}

extension SearchVC: SearchViewDelegate {
    func didTappedSearchButton() {
        print("Hureeey")
    }
}
