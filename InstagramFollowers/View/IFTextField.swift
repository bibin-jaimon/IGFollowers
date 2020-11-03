//
//  IFTextField.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit

class IFTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        enableProgramaticUI()
        font = UIFont.systemFont(ofSize: 25, weight: .bold)
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.borderColor = IFColors.textFiledBorderColor.cgColor
        autocorrectionType = .no
        returnKeyType = .go
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}

