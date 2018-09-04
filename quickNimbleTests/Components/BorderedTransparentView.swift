//
//  RoundView.swift
//  quickNimbleTests
//
//  Created by Rodrigo Longhi Guimarães on 29/08/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class BorderedTransparentView: UIView {
    
    @IBInspectable var viewBackgroundColor: UIColor = UIColor.white.withAlphaComponent(0.2)
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
//        self.layer.borderWidth = 2
//        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = self.viewBackgroundColor
    }
}
