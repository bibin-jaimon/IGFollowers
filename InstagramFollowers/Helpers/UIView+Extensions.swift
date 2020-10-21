//
//  UIView+Extensions.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import Foundation
import UIKit

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
