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
            NotificationCenter.default.post(name: Notification.Name("updateTextView"), object: nil)
        }
    }
    
    private var elements: [String] {
        return  calculString.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    private  var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var atLeastOneNumber : Bool {
        if calculString >= "0" && calculString <= "9"{
            return elements.count >= 1 }
        else {
            NotificationCenter.default.post(name: Notification.Name("BeginWithOperator"), object: nil)
        }
        return false
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
    
    func addNumber(number: String) {
        if expressionHaveResult {
            calculString = ""
        }
        calculString.append(number)
    }
    
    func cleanNumber() {
        calculString = ""
        
    }
    
    func addOperator(operation: String) {
        if atLeastOneNumber {
            if canAddOperator {
                
                switch operation {
                case "+":
                    calculString.append(" + ")
                case "-":
                    calculString.append(" - ")
                case "x":
                    calculString.append(" x ")
                case "/":
                    calculString.append(" / ")
                default : break // notif
                }
            }
        }
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
    
    func orderOfOperationAndCalculate() {
        var operation = elements
        let priorityOperator = ["x","/"]
        let calcOperator = ["+","-"]
        var result = ""
        var operatorIndex : Int?
        
        guard expressionIsCorrect else {
            NotificationCenter.default.post(name: Notification.Name("notifAlertCorrectExpression"), object: nil)
            return
        }
        
        guard expressionHaveEnoughElement else {
            NotificationCenter.default.post(name: Notification.Name("notifAlertStartNewCalcul"), object: nil)
            return
        }
        
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
            if let index = operatorIndex {
                let calculOperator = operation[index]
                let left = Double(operation[index - 1])
                let right = Double(operation[index + 1])
                result = format(number: calculate(left: left!, right: right!, calculOperator: calculOperator))
                operation[index] = result
                operation.remove(at : index + 1)
                operation.remove(at : index - 1)}
        }
        calculString = calculString + " = \(operation[0])"
    }
}
