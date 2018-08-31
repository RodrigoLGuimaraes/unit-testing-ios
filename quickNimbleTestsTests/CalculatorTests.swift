//
//  quickNimbleTestsTests.swift
//  quickNimbleTestsTests
//
//  Created by Rodrigo Longhi Guimarães on 29/08/18.
//  Copyright © 2018 Rodrigo Longhi Guimarães. All rights reserved.
//

import Quick
import Nimble

@testable import quickNimbleTests

class CalculatorTests: QuickSpec {
    
    override func spec() {

        describe("calculator") {
            describe("calculation input has error") {
                it("calculation result has error") {
                    //ARRANGE
                    let input = CalculationInput(
                        singlePaymentValue: 0,
                        installmentValue: 0,
                        numberOfInstallments: 0,
                        annualRevenue: 0,
                        error: NSError(domain: "", code: 403, userInfo: nil))
                    
                    //ACT
                    let result = Calculator.calculateCurrentValues(input: input)
                    
                    //EXPECT
                    expect(result.error).notTo(beNil())
                }
            }
            
            describe("calculation input does not has error") {
                it("calculation result has correct value") {
                    //ARRANGE
                    let input = CalculationInput(
                        singlePaymentValue: 30,
                        installmentValue: 10,
                        numberOfInstallments: 3,
                        annualRevenue: 5,
                        error: nil)
                    
                    /*
                     Monthly interest: 1.05 ^ (1/12) = 1.0040741238
                     30 + (((30 * monthly - 10) * monthly - 10) * monthly - 10) = 30.2457773355
                    */
                    
                    //ACT
                    let result = Calculator.calculateCurrentValues(input: input)
                    
                    //EXPECT
                    expect(result.totalSingleValue).to(beCloseTo(30.2457773355))
                }
            }
            
        }


    }
    
}
