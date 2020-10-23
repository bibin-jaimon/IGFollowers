//
//  FollowerCell.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 22/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import Foundation
import UIKit

class FollowerCell: UICollectionViewCell {
    
    var followerViewModel: FollowersViewModel?
    
    lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.enableProgramaticUI()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.enableProgramaticUI()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    private func configureView() {
        addSubviews(profileImageView, nameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureProfileImageView()
        configureNameLabel()
    }
    
    private func configureNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 0),
            nameLabel.leftAnchor.constraint(equalTo: self.profileImageView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: self.profileImageView.rightAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 2)
        ])
    }
    
    private func configureProfileImageView() {
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            profileImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        ])
        
    }
    
    func setupCell(with data: FollowersViewModel) {
        self.followerViewModel = data
        self.nameLabel.text = followerViewModel?.name

        NetworkManager.shared.loadImage(from: followerViewModel!.imageURL) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            default:
                break
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
