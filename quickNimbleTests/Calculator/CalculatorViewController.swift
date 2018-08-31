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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
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
    
    private func compoundInterest(initialValue: Double, numberOfPeriods: Int, interestPerPeriod: Double) -> Double {
        
        var amount = initialValue
        
        for _ in 0..<numberOfPeriods {
            amount *= interestPerPeriod
        }
        
        return amount
    }
    
    @IBAction func didAskForResult(_ sender: Any) {
        guard let singlePaymentValue = self.singlePaymentValue.text?.toDouble(),
              let installmentValue = self.installmentValue.text?.toDouble(),
              let numberOfInstallments = self.installmentQuantity.text?.toInt(),
              numberOfInstallments > 0 else {
                let alert = UIAlertController(title: "Ops", message: "Tem algum dado errado, confere lá?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        
        let annualRevenue = self.rentabilityPercentage.text?.toDouble() ?? 5.0 //TODO: retrieve percentage
        
        let annualMultiplier = 1 + (annualRevenue/100)
        
        let monthlyMultiplier = pow(annualMultiplier, 1/12.0)
        
        let totalValueInstallments = Double(numberOfInstallments) * installmentValue
        
        var totalValueAfterInvestment: Double = singlePaymentValue
        
        var currentInvestedValue = singlePaymentValue
        for _ in 1...numberOfInstallments {
            let newCurrentInvestedValue = currentInvestedValue * monthlyMultiplier
            totalValueAfterInvestment += newCurrentInvestedValue - currentInvestedValue
            currentInvestedValue = newCurrentInvestedValue - installmentValue
            
            if currentInvestedValue < 0 {
                break
            }
        }
        
        let resultViewController = ResultViewController(totalSingleValue: totalValueAfterInvestment, totalInstallmentsValue: totalValueInstallments)
        resultViewController.modalTransitionStyle = .crossDissolve
        resultViewController.modalPresentationStyle = .overCurrentContext
        self.present(resultViewController, animated: true, completion: nil)
    }
    
    
}
