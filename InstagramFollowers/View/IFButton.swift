//
//  IFButton.swift
//  InstagramFollowers
//
//  Created by Bibin Jaimon on 21/10/20.
//  Copyright © 2020 noOne. All rights reserved.
//

import UIKit

class IFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .systemPink : .none
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        commonInit()
    }
    
    private func commonInit() {
        self.enableProgramaticUI()
        isEnabled = false
        layer.borderColor = UIColor.systemPink.cgColor
        layer.borderWidth = 1
        titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        setTitleColor(.white, for: .normal)
        setTitleColor(.systemPink, for: .disabled)
    }
}
