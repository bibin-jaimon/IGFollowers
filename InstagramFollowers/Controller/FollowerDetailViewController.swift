//
//  FollowerDetailViewController.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 22/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit
import SwiftUI

struct FollowerDetailsView: View {
    
    var user: User
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                HStack {
                    RemoteImage(url: user.avatar_url).aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .cornerRadius(10)
                        
                    VStack {
                        Text(user.login).foregroundColor(.black)
                        Text(user.name).foregroundColor(.black)
                        Text("Hellow world").foregroundColor(.black)
                    }
                }
                Text(user.bio).foregroundColor(.black)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

//class FollowerDetailViewController: UIViewController {
//
//    var followerViewModel: FollowersViewModel
//
//    lazy var followerDetailsView: FollowerDetailView = FollowerDetailView()
//
//    override func loadView() {
//        self.view = followerDetailsView
//    }
//
//    init(followersViewModel: FollowersViewModel) {
//        self.followerViewModel = followersViewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .blue
//    }
//
//}
//
//class FollowerDetailView: UIView {
//
//    lazy var profileImage: UIImageView = {
//       let imageView = UIImageView()
//        imageView.enableProgramaticUI()
//        return imageView
//    }()
//
//    init() {
//        super.init(frame: .zero)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    private func commonInit() {
//        addSubviews(profileImage)
//
//        NSLayoutConstraint.activate([
//            profileImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            profileImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            profileImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            profileImage.heightAnchor.constraint(equalToConstant: 300)
//        ])
//
////        NetworkManager.shared.loadImage(from: <#T##String#>, then: <#T##(Result<UIImage, IFError>) -> Void#>)
//    }
//}

struct FollowerDetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(bio: "iOS Developer specializing in Swift",
                            name: "Sean Allen",
                            login: "SAllen0400",
                            avatar_url: "https://avatars2.githubusercontent.com/u/10645516?v=4",
                            html_url: "https://github.com/SAllen0400",
                            public_repos: 1,
                            followers: 693,
                            following: 0,
                            public_gists: 14)
        return FollowerDetailsView(user: user)
    }
}
