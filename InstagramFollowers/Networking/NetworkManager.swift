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

struct Followers: Decodable {
    let login: String
    let avatar_url: String
    let html_url: String
}

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
}


extension URLSession {
    func perform<T>(url: URL, responseModel: T.Type, then: @escaping (Result<[T], IFError>) -> Void) where T: Decodable {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                then(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                then(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                then(.failure(.invalidData))
                return
            }
            
            do {
                let followers: [T] = try JSONDecoder().decode([T].self, from: data)
                then(.success(followers))
            } catch let error {
                print(error.localizedDescription)
            }
                            
        }.resume()
        
    }
}
