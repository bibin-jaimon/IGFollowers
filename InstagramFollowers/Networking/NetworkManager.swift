//
//  NetworkManager.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 22/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import Foundation
import Combine
import UIKit


public let BASE_URL = "https://api.github.com/"
//https://api.github.com/users/dmyma/followers?per_page=4&page=4

enum IFError: String, Error {
    case invalidUser = "No user fount"
    case unableToComplete
    case invalidResponse
    case invalidData
}

class NetworkManager {
    
    public static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    func getFollowers(for userID: String) -> Future<[Followers], IFError> {
        let url = URL(string: "\(BASE_URL)users/\(userID)/followers")!
        print(url.absoluteURL)
        
        return Future { promise in
            URLSession.shared.perform(url: url, responseModel: Followers.self) { (result) in
                switch result {
                case .success(let followers):
                    promise(.success(followers))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    
    
    func loadImage(from url: String, then: @escaping (Result<UIImage, IFError>) -> Void) {
        
        if let image = self.cache.object(forKey: url as NSString) {
            then(.success(image))
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.load(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                self?.cache.setObject(image, forKey: url as NSString)
                then(.success(image))
            case .failure(_):
                then(.failure(.invalidData))
                break
            }
            
        }
    }
    
}
