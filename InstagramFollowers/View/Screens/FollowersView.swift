//
//  FollowersView.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 22/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit
import Combine

enum IFActions {
    case loadMoreFollowers
    case showFollowerDetails(FollowersViewModel)
}

final class FollowersView: UIView {
    
    var followerViewModel = [FollowersViewModel]()
    let cellID = "CellID"
    
    enum Section {
        case main
    }
    
    typealias IFDataSource = UICollectionViewDiffableDataSource<Section, FollowersViewModel>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, FollowersViewModel>
    private lazy var dataSource = makeDataSource()
    
    var followerViewPublisher = PassthroughSubject<IFActions, Never>()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.enableProgramaticUI()
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.backgroundColor = .systemGray6
        addSubviews(collectionView)
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        applySnapShot(animatingDifferences: false)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: cellID)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func updateData(_ data: [FollowersViewModel]) {
        self.followerViewModel = data
        applySnapShot()
    }
    
    private func makeDataSource() -> IFDataSource {
        
        let dataSource = IFDataSource(collectionView: collectionView) {[weak self] (collectionView, indexPath, followerViewModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self!.cellID, for: indexPath) as? FollowerCell
            cell?.setupCell(with: followerViewModel)
            return cell
        }
        
        
        return dataSource
    }
    
    private func applySnapShot(animatingDifferences: Bool = true) {
        var snapShot = SnapShot()
        snapShot.appendSections([.main])
        snapShot.appendItems(followerViewModel)
        dataSource.apply(snapShot, animatingDifferences: animatingDifferences)
    }

}

extension FollowersView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let follower = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        followerViewPublisher.send(.showFollowerDetails(follower))
    }

}

extension FollowersView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var length = (UIScreen.main.bounds.size.width / 3) - 10
        length = length < 150 ? length : 150
        
        return CGSize(width: length, height: length + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == followerViewModel.count - 6 {
            followerViewPublisher.send(.loadMoreFollowers)
        }
    }
}
