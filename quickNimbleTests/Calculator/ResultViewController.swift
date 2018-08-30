//
//  ResultViewController.swift
//  quickNimbleTests
//
//  Created by Rodrigo Longhi Guimarães on 30/08/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultValueLabel: UILabel!
    @IBOutlet weak var investedValue: UILabel!
    @IBOutlet weak var totalValueInstallments: UILabel!
    
    var totalSingleValue: Double
    var totalInstallmentsValue: Double
    
    init(totalSingleValue: Double, totalInstallmentsValue: Double) {
        self.totalSingleValue = totalSingleValue
        self.totalInstallmentsValue = totalInstallmentsValue
        
        super.init(nibName: String(describing: "ResultViewController"), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.configureViews()
    }
    
    func configureViews() {
        
        self.resultLabel.text = (self.totalSingleValue > self.totalInstallmentsValue) ?
            "Pague a vista!" :
            "Pague parcelado!"
        
        let moneyEarned = (self.totalSingleValue - totalInstallmentsValue).magnitude
        self.resultValueLabel.text = "Você economizou R$\(moneyEarned.format(f: ".2"))"
        
        self.investedValue.text = "VALOR A VISTA APÓS INVESTIMENTO:\nR$\(self.totalSingleValue.format(f: ".2"))"
        self.totalValueInstallments.text = "VALOR DO PARCELAMENTO:\nR$\(self.totalInstallmentsValue.format(f: ".2"))"
    }

}
