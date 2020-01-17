//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {

   var calcul: Calcul!

      override func setUp() {
          super.setUp()
          calcul = Calcul()
      }
      func testGivenIsExpressionCorrect_WhenStringNumberIsNil_ThenExpressionReturnFalse() {
        XCTAssertTrue(calcul.expressionIsCorrect)
      }
    
    func testGivenexpressionHaveEnoughElement_whenStringgreaterThanOrEqualTo3_ThenReturnTrue() {
        calcul.calculString = "2 + 2"
        XCTAssertTrue(calcul.expressionHaveEnoughElement)
    }
    
    func testGivencanAddOperator_whencanAddOperator_ThenReturnTrue() {
           calcul.calculString = "2 + 2 + 3"
           XCTAssertTrue(calcul.canAddOperator)
       }
     
    func testexpressionHaveResult_whenexpressionHaveResult_ThenReturnTrue() {
        calcul.calculString = "= 30"
        XCTAssertTrue(calcul.expressionHaveResult)
    }
    
    func testaddNumber_whenaddNumber_ThenReturnNumber() {
        calcul.addNumber(number: "3")
        XCTAssert(calcul.calculString == "3")
    }
    
    func testaddOperator_whenaddOperator_ThenreturnFalse() {
        calcul.addOperator(operation: "+")
        XCTAssertFalse(calcul.calculString == "+")
    }
    func testcalculate_whenorderOfOperationAndCalculateCalculate_ThenreturnTrue() {
        let result = calcul.calculate( left : 1.0, right : 1.0, calculOperator : "+")
        XCTAssertTrue(result == 2)
    }
    func testorderOfOperationAndCalculate_whenTappedEqualButton_ThenreturnTrue() {
       calcul.addNumber(number: "1")
        calcul.addOperator(operation: "+")
        calcul.addNumber(number: "1")
        calcul.addOperator(operation: "x")
        calcul.addNumber(number: "3")
        calcul.addOperator(operation: "/")
        calcul.addNumber(number: "2")
        calcul.orderOfOperationAndCalculate()
        XCTAssert(calcul.calculString == "1 + 1 x 3 / 2 = 2.5")
    }
    
    func testcleanNumber_whenTappedACButton_ThenreturnTrue() {
          calcul.cleanNumber()
          XCTAssertTrue(calcul.calculString == "")
          
      }
    
    func testelements_whenTappedACButton_ThenreturnTrue() {
            
             
         }
    

    
}
