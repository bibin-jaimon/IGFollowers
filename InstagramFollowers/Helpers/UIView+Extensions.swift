//
//  UIView+Extensions.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import Foundation
import UIKit

fileprivate var indicatorView: UIView?

extension UIViewController {
    
    func showSpinner() {
        indicatorView = UIView(frame: self.view.bounds)
        
        indicatorView!.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: .large)
        
        ai.center = indicatorView!.center
        ai.startAnimating()
        
        indicatorView!.addSubview(ai)
        self.view.addSubview(indicatorView!)
    }
    
    func hideSpinner() {
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { (view) in
            addSubview(view)
        }
    }
    
    func enableProgramaticUI () {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}

extension NSLayoutConstraint {
    func activate(_ constraints :[NSLayoutConstraint]) {
        constraints.forEach { (constraint) in
            constraint.isActive = true
        }
    }
    
}

extension URLSession {
    
    func load(from url: URL, then: @escaping (Result<UIImage, IFError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                then(.success(image))
            } else {
                then(.failure(.invalidData))
            }
        }.resume()
    }
    
    func perform<T>(url: URL, responseModel: T.Type, then: @escaping (Result<T, IFError>) -> Void) where T: Decodable {
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
                let followers: T = try JSONDecoder().decode(T.self, from: data)
                then(.success(followers))
            } catch let error {
                then(.failure(.unableToParseJSON))
                print(error.localizedDescription)
            }
                            
        }.resume()
    }
}
