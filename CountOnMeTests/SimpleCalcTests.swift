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
        // corriger espacement
    }
    
    func testcleanNumber_whenTappedACButton_ThenreturnTrue() {
        calcul.cleanNumber()
        XCTAssertTrue(calcul.calculString == "")
    }
    
    
    func testAddNumber_whenTappedButtonNumber_ThenreturnTrue() {
        calcul.addNumber(number: "1")
        XCTAssertTrue(calcul.canAddOperator)
    }
    
    
    func testAtLeastOneNumber_whenBeginWithOperator_Thenreturnfalse(){
        
        calcul.addOperator(operation: "+")
        XCTAssertFalse(calcul.atLeastOneNumber)
        
    }
    
    func testExpressionHaveResult_expressionHaveResult_ThenreturnTrue(){
        calcul.calculString = "1 + 1 = 2"
        calcul.addNumber(number : "2")
        XCTAssertTrue(calcul.calculString == "2")
    }
    
    func testnotDivisionByZero_whenDivisionByZero_ThenreturnNotification(){
        
        expectation(forNotification: NSNotification.Name(rawValue:"error"), object: nil, handler: nil)
        calcul.calculString = "1 / 0 "
        calcul.orderOfOperationAndCalculate()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    
    func testoperatorLess_whenAddLessOperator_ThenreturnTrue(){
        calcul.calculString = "2 - 1"
        calcul.addOperator(operation: "-")
        XCTAssertTrue(calcul.calculString == "2 - 1 - ")
    }
    
    
    func testnotMoreThanOneOperator_whenAddLessOperator_ThenreturnFalse(){
        calcul.calculString = "+ "
        calcul.addOperator(operation: "+")
        XCTAssertFalse(calcul.canAddOperator)
    }
    
    
    func testEnterACorrectExpression_whenIncompletCalcul_ThenreturnNotification(){
        expectation(forNotification: NSNotification.Name(rawValue:"error"), object: nil, handler: nil)
        calcul.calculString = "1 + "
        calcul.orderOfOperationAndCalculate()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testStartNewCalcul_whenTappedEqualButtonWithNoCalcul_ThenreturnNotification(){
          expectation(forNotification: NSNotification.Name(rawValue:"error"), object: nil, handler: nil)
          calcul.calculString = "1"
          calcul.orderOfOperationAndCalculate()
          waitForExpectations(timeout: 0.1, handler: nil)
      }
    
}
