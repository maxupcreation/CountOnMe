//
//  Operation.swift
//  CountOnMe
//
//  Created by Maxime on 18/12/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calcul {
    
    var calculString = "" {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("updateString"), object: nil)
        }
    }
    
    var elements: [String] {
        return  calculString.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveResult: Bool {
        return calculString.firstIndex(of: "=") != nil
    }
    
    func format(number: Double) -> String {
           let formater = NumberFormatter()
           formater.minimumFractionDigits = 0
           formater.maximumFractionDigits = 2
           guard let value = formater.string(from: NSNumber(value:number)) else { return ""}
           return value
       }
    
    func calculate( left : Double, right : Double, calculOperator : String) -> Double {
        var result : Double = 0
        switch calculOperator {
        case "x" : result = left * right
        case "/":result = left / right
        case "+" :result = left + right
        case "-":result = left - right
        default : print("error")
        }
        return result
    }
    
    func OrderOfOperationAndCalculate() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "calculateNotification"), object: nil)
        var operation = elements
        let priorityOperator = ["x","/"]
        let calcOperator = ["+","-"]
        var result : Double = 0
        var operatorIndex : Int?
        
        while operation.count > 1 {
            
            
            let firstIndexPriorityOperator = operation.firstIndex(where : {priorityOperator.contains($0)})
            if let priorityOperatorIndex = firstIndexPriorityOperator {
                operatorIndex = priorityOperatorIndex
            } else {
                let firstIndexOfOperation = operation.firstIndex(where : {calcOperator.contains($0)})
                if let normalOperatorIndex = firstIndexOfOperation{
                    operatorIndex = normalOperatorIndex
                }
            }
        }
        if let index = operatorIndex {
            
            let calculOperator = operation[index]
            let left = Double(operation[index - 1])
            let right = Double(operation[index + 1])
            result = calculate(left: left!, right: right!, calculOperator: calculOperator)
            operation[index] = "\(result)"
            operation.remove(at : index + 1)
            operation.remove(at : index - 1)
        }
        calculString = calculString + "=\(operation[0])"
    }
    
}

