//
//  IFTextField.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit

class IFTextField: UITextField {

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
    }
    
}
