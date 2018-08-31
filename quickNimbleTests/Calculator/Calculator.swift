//
//  Calculator.swift
//  quickNimbleTests
//
//  Created by Rodrigo Guimaraes on 31/08/2018.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Foundation

struct CalculationInput {
    let singlePaymentValue: Double
    let installmentValue: Double
    let numberOfInstallments: Int
    let annualRevenue: Double
    let error: Error?
}

struct CalculationResult {
    let totalSingleValue: Double
    let totalInstallmentsValue: Double
    let error: Error?
}


struct Calculator {
    static func compoundInterest(initialValue: Double, numberOfPeriods: Int, interestPerPeriod: Double) -> Double {
        
        var amount = initialValue
        
        for _ in 0..<numberOfPeriods {
            amount *= interestPerPeriod
        }
        
        return amount
    }
    
    static func calculateCurrentValues(input: CalculationInput) -> CalculationResult {
        guard input.error == nil else {
            return CalculationResult(totalSingleValue: 0, totalInstallmentsValue: 0, error: input.error)
        }
        
        let annualMultiplier = 1 + (input.annualRevenue/100)
        let monthlyMultiplier = pow(annualMultiplier, 1/12.0)
        
        let totalValueInstallments = Double(input.numberOfInstallments) * input.installmentValue
        
        var totalValueAfterInvestment: Double = input.singlePaymentValue
        
        var currentInvestedValue = input.singlePaymentValue
        for _ in 1...input.numberOfInstallments {
            let newCurrentInvestedValue = currentInvestedValue * monthlyMultiplier
            totalValueAfterInvestment += newCurrentInvestedValue - currentInvestedValue
            currentInvestedValue = newCurrentInvestedValue - input.installmentValue
            
            if currentInvestedValue < 0 {
                break
            }
        }
        
        return CalculationResult(totalSingleValue: totalValueAfterInvestment, totalInstallmentsValue: totalValueInstallments, error: nil)
    }
}
