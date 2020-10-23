//
//  FollowersModelView.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 22/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import Foundation
import UIKit

struct FollowersViewModel: Hashable {
    static func == (lhs: FollowersViewModel, rhs: FollowersViewModel) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    let follower: Followers
    
    var name: String {
        return follower.login
    }
    
    var imageURL: String {
        return follower.avatar_url
    }
    
    init(follower: Followers) {
        self.follower = follower
    }    
}
