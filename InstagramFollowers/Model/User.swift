//
//  User.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 23/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import Foundation

struct User: Decodable {
    let bio             : String
    let name            : String
    let login           : String
    let avatar_url      : String
    let html_url        : String
    let public_repos    : Int
    let followers       : Int
    let following       : Int
    let public_gists    : Int
}
