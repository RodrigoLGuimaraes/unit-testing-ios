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
    
    private func retrieveCalculationInput() -> CalculationInput {
        guard let singlePaymentValue = self.singlePaymentValue.text?.toDouble(),
            let installmentValue = self.installmentValue.text?.toDouble(),
            let numberOfInstallments = self.installmentQuantity.text?.toInt(),
            numberOfInstallments > 0 else {
                return CalculationInput(singlePaymentValue: 0,
                                        installmentValue: 0,
                                        numberOfInstallments: 0,
                                        annualRevenue: 0,
                                        error: NSError(domain: "", code: 403, userInfo: nil))
        }
        
        let annualRevenue = self.rentabilityPercentage.text?.toDouble() ?? 4.55022554
        
        return CalculationInput(singlePaymentValue: singlePaymentValue,
                                installmentValue: installmentValue,
                                numberOfInstallments: numberOfInstallments,
                                annualRevenue: annualRevenue, error: nil)
    }
    
    @IBAction func didAskForResult(_ sender: Any) {
        let calcInput = self.retrieveCalculationInput()
        
        guard calcInput.error == nil else {
            self.showErrorAlert()
            return
        }
        
        let calcResult = Calculator.calculateCurrentValues(input: calcInput)
        self.presentResult(totalSingleValue: calcResult.totalSingleValue, totalInstallmentsValue: calcResult.totalInstallmentsValue)
    }
    
    
}
