//
//  CalculatorViewController.swift
//  quickNimbleTests
//
//  Created by Rodrigo Longhi Guimarães on 29/08/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    init() {
        super.init(nibName: String(describing: "CalculatorViewController"), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.configureViews()
    }
    
    func configureViews() {
        
    }
    
}
