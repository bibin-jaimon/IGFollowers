//
//  Followers.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 22/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import Foundation

struct Followers: Decodable {
    let login: String
    let avatar_url: String
    let html_url: String
}
