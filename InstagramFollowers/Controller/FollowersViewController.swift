//
//  FollowersViewController.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 22/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit
import Combine

class FollowersViewController: UIViewController {
    
    let followersViewModel: [FollowersViewModel]
    var username: String?
    
    var tokens = Set<AnyCancellable>()
    
    var getUserToken: AnyCancellable?
    
    var followersView = FollowersView()
    
    override func loadView() {
        view = followersView
    }
    
    init(followersViewModel: [FollowersViewModel], title: String) {
        self.followersViewModel = followersViewModel
        username = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = username
        followersView.updateData(followersViewModel)
        
        createSearchController()
        
        getUserToken = followersView.showFollowerDetailsPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (follower) in
                print(follower.name)
                //api call for fetch details
                let followerDetailsVC = FollowerDetailViewController()
                self.present(followerDetailsVC, animated: true, completion: nil)
            })
    }
    
    private func createSearchController() {
        
        let searchController = IFSearchBar()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        
        searchController.searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] (searchText) in
                self?.filterFollowers(with: searchText)
        }.store(in: &tokens)
    }
    
    private func filterFollowers(with text: String) {
        
    }
    
    deinit {
        getUserToken?.cancel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
    }

}
