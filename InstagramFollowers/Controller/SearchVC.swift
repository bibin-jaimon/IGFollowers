//
//  SearchVC.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit
import Combine

class SearchVC: UIViewController {
    
    private var searchView: SearchView!
    private var getFollowersToken: AnyCancellable?
        
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
        self.showSpinner()
        
        getFollowersToken = NetworkManager.shared.getUser(for: searchTerm)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] (completion) in
                self?.hideSpinner()
                switch completion {
                case .failure(_):
                    break
                case .finished:
                    break
                }
                }, receiveValue: {[weak self] user in
                    self?.hideSpinner()
                    let followersVC = FollowersViewController(user: user)
                    self?.navigationController?.pushViewController(followersVC, animated: true)
            })
    }
}
