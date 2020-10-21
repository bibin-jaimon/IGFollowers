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
        backgroundColor = .systemPink
        titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        layer.cornerRadius = 10
    }
}
