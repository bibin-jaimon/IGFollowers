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
    
    let cache = NSCache<NSString, UIImage>()
    public static let shared = NetworkManager()
    private init() { }
    
    func getFollowers(for userID: String) -> Future<[Followers], IFError> {
        let url = URL(string: "\(BASE_URL)users/\(userID)/followers")!
        print(url.absoluteURL)
        
        return Future { promise in
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let _ = error {
                    promise(.failure(.unableToComplete))
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    promise(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    promise(.failure(.invalidData))
                    return
                }
                
                do {
                    let followers: [Followers] = try JSONDecoder().decode([Followers].self, from: data)
                    promise(.success(followers))
                } catch let error{
                    print(error.localizedDescription)
                }
                                
            }.resume()
            
            
        }
        
    }
    
}

//
//enum IFHTTPMethod {
//    case post
//    case get
//}
//
//protocol Router {
//    var baseURL: String { get }
//    var endPoint: String { get }
//    var method: IFHTTPMethod { get }
//}
//
//enum UserRouter: Router {
//
//    var baseURL: String {
//        return BASE_URL + "/users/"
//    }
//
//    case getUserData(String)
//    case getFollowers(String)
//
//    var endPoint: String {
//        switch self {
//        case .getFollowers(let userID):
//            return "\(userID)/followers"
//
//        case .getUserData(let userID):
//            return "\(userID)"
//        }
//    }
//
//    var method: IFHTTPMethod {
//        switch self {
//        case .getFollowers, .getUserData:
//            return .get
//        }
//    }
//}
//
//protocol Service {}
//
//extension Service {
//    func perform(request: )
//}
