//
//  CalculatorViewController.swift
//  quickNimbleTests
//
//  Created by Rodrigo Longhi Guimarães on 29/08/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import UIKit

struct CalculationResult {
    let totalSingleValue: Double
    let totalInstallmentsValue: Double
    let error: Error?
}

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
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Ops", message: "Tem algum dado errado, confere lá?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func presentResult(totalSingleValue: Double, totalInstallmentsValue: Double) {
        let resultViewController = ResultViewController(totalSingleValue: totalSingleValue, totalInstallmentsValue: totalInstallmentsValue)
        resultViewController.modalTransitionStyle = .crossDissolve
        resultViewController.modalPresentationStyle = .overCurrentContext
        self.present(resultViewController, animated: true, completion: nil)
    }
    
    private func calculateCurrentValues() -> CalculationResult {
        guard let singlePaymentValue = self.singlePaymentValue.text?.toDouble(),
            let installmentValue = self.installmentValue.text?.toDouble(),
            let numberOfInstallments = self.installmentQuantity.text?.toInt(),
            numberOfInstallments > 0 else {
                return CalculationResult(totalSingleValue: 0, totalInstallmentsValue: 0, error: NSError(domain: "", code: 403, userInfo: nil))
        }
        
        let annualRevenue = self.rentabilityPercentage.text?.toDouble() ?? 4.55022554
        
        let annualMultiplier = 1 + (annualRevenue/100)
        let monthlyMultiplier = pow(annualMultiplier, 1/12.0)
        
        let totalValueInstallments = Double(numberOfInstallments) * installmentValue
        
        var totalValueAfterInvestment: Double = singlePaymentValue
        
        var currentInvestedValue = singlePaymentValue
        for i in 1...numberOfInstallments {
            totalValueAfterInvestment += self.compoundInterest(initialValue: currentInvestedValue, numberOfPeriods: i, interestPerPeriod: monthlyMultiplier) - currentInvestedValue
            
            currentInvestedValue -= installmentValue
            if currentInvestedValue > 0 {
                break
            }
        }
        
        return CalculationResult(totalSingleValue: totalValueAfterInvestment, totalInstallmentsValue: totalValueInstallments, error: nil)
    }
    
    @IBAction func didAskForResult(_ sender: Any) {
        let calcResult = self.calculateCurrentValues()
        
        guard calcResult.error == nil else {
            self.showErrorAlert()
            return
        }
        
        self.presentResult(totalSingleValue: calcResult.totalSingleValue, totalInstallmentsValue: calcResult.totalInstallmentsValue)
    }
    
    
}
