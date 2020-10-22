//
//  FollowersModelView.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 22/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import Foundation
import UIKit

struct FollowersViewModel {
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
