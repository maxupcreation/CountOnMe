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
}
