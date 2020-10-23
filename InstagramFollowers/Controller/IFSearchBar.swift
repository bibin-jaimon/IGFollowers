//
//  IFSearchBar.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 23/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit
import Combine

class IFSearchBar: UISearchController, UISearchBarDelegate {

    var searchTextPublisher = PassthroughSubject<String, Never>()
    
    init() {
        super.init(searchResultsController: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        searchBar.placeholder = "Search for followers"
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextPublisher.send(searchText)
    }
}
