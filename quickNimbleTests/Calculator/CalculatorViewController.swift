//
//  CalculatorViewController.swift
//  quickNimbleTests
//
//  Created by Rodrigo Longhi Guimarães on 29/08/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var singlePaymentValue: UITextField!
    @IBOutlet weak var rentabilityPercentage: UITextField!
    @IBOutlet weak var installmentQuantity: UITextField!
    @IBOutlet weak var installmentValue: UITextField!
    
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
    
    @IBAction func didAskForResult(_ sender: Any) {
        guard let singlePaymentValue = self.singlePaymentValue.text?.toDouble(),
              let installmentValue = self.installmentValue.text?.toDouble(),
              let numberOfInstallments = self.installmentQuantity.text?.toInt() else {
                //TODO: show error
                return
        }
        
        
    }
    
    
}
