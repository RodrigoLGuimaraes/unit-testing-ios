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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
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
        
        let difference = (self.totalSingleValue - totalInstallmentsValue)
        
        let moneyEarned = difference.magnitude
        self.resultValueLabel.text = "Você vai economizar R$\(moneyEarned.format(f: ".2"))"
        
        if difference < 0 {
            self.resultLabel.text = "Pague a vista!"
            
            self.descriptionLabel.text = "Se você pagar parcelado e aplicar o valor a vista, vão faltar \(moneyEarned.format(f: ".2")) reais na hora de pagar as parcelas."
            
            iconView.image = UIImage(named: "money")
        } else {
            self.resultLabel.text = "Pague parcelado!"
            
            self.descriptionLabel.text = "Se você pagar parcelado e aplicar o valor a vista, vão sobrar \(moneyEarned.format(f: ".2")) reais após pagar as parcelas."
            
            iconView.image = UIImage(named: "card")
        }
        
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
