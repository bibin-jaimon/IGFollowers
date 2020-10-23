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
    
    var followersViewModel = [FollowersViewModel]()
    var userDetails: User
    var username: String?
    var tokens = Set<AnyCancellable>()
    var getUserToken: AnyCancellable?
    var followersView = FollowersView()
    var hasMoreFollowers: Bool {
        return followersViewModel.count < userDetails.followers
    }
    var page = 1
    
    init(user: User) {
        self.userDetails = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = followersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = userDetails.login
        fetchFollowersData()
        createSearchController()
        subscribeFollowersViewPublisher()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.layoutIfNeeded()
    }
    
    private func subscribeFollowersViewPublisher() {
        getUserToken = followersView.followerViewPublisher
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: {[weak self] (action) in
            
            switch action {
            case .loadMoreFollowers:
                self?.fetchFollowersData()
                break
            case .showFollowerDetails(let follower):
                print(follower.name)
                let followerDetailsVC = FollowerDetailViewController()
                self?.present(followerDetailsVC, animated: true, completion: nil)
                break
            }

        })
    }
    
    private func fetchFollowersData() {
        if hasMoreFollowers {
            self.showSpinner()
            NetworkManager.shared.getFollowers(for: userDetails.login, page: page)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { (result) in
                    
                }, receiveValue: {[weak self] followers in
                    let followersViewModel = followers.map({ return FollowersViewModel(follower: $0) })
                    self?.followersViewModel.append(contentsOf: followersViewModel)
                    self?.page += 1
                    self?.followersView.updateData((self?.followersViewModel)!)
                    self?.hideSpinner()
                }).store(in: &tokens)
        }
    }
    
    private func createSearchController() {
        
        let searchController = IFSearchBar()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] (searchText) in
                searchController.searchBar.text = searchText
                self?.filterFollowers(with: searchText)
        }.store(in: &tokens)
    }
    
    private func filterFollowers(with text: String) {
        
        guard !text.isEmpty else {
            followersView.updateData(followersViewModel)
            return
        }
        
        let filteredArray = self.followersViewModel.filter {
            $0.name.lowercased().contains(text.lowercased())
        }
        
        followersView.updateData(filteredArray)
        
    }
    
    deinit {
        getUserToken?.cancel()
        tokens.forEach { (token) in
            token.cancel()
        }
    }

}

