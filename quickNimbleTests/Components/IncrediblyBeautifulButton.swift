//
//  IncrediblyBeautifulButton.swift
//  quickNimbleTests
//
//  Created by Rodrigo Longhi Guimarães on 30/08/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class IncrediblyBeautifulButton: UIButton {

    let bgColor = UIColor.init(red: 110/255.0, green: 69/255.0, blue: 100/255.0, alpha: 0.6)
    
    override func awakeFromNib() {
        self.backgroundColor = bgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.setTitleColor(UIColor.white, for: .normal)
    }

}
