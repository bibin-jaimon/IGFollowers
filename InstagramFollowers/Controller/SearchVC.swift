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
    
    //TODO:- refactor code to MVVM
    //Why we need getFollowersToken
    
    func didTappedSearchButton(for searchTerm: String) {
        getFollowersToken = NetworkManager.shared.getFollowers(for: searchTerm)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { ( completion) in
                    switch completion {
                    case .finished:
                        print("Completion stops observing")
                    case .failure(let error):
                        print("Error: \(error.rawValue)")
                    }
            }, receiveValue: {[weak self] (followers) in
                let followersViewModel = followers.map({ return FollowersViewModel(follower: $0) })
                let followersVC = FollowersViewController(followersViewModel: followersViewModel, title: searchTerm)
                self?.navigationController?.pushViewController(followersVC, animated: true)
            })
    }
}
