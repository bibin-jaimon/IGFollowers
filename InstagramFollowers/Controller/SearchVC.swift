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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension SearchVC: SearchViewDelegate {
    func didTappedSearchButton(for searchTerm: String) {
        print(searchTerm)
    }
}
