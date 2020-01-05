//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Maxime Berthet
//  Copyright © 2019 Maxime Berthet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
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
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if expressionHaveResult {
            textView.text = ""
        }
        
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" + ")
        } else {
            alertOperator(.operatorIsAlreadyInPlace)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(" - ")
        } else {
            alertOperator(.operatorIsAlreadyInPlace)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        if canAddOperator {
            textView.text.append(" x ")
        } else {
            alertOperator(.operatorIsAlreadyInPlace)
        }
        
    }
    
    @IBAction func tappedDivisionButton(_ sender: Any) {
        if canAddOperator {
            textView.text.append(" / ")
        } else {
            alertOperator(.operatorIsAlreadyInPlace)
        }
        
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            alertOperator(.enterACorrectExpression)
            return
        }
        
        guard expressionHaveEnoughElement else {
            alertOperator(.startANewCalcul)
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        var result: Double = 0
        var indexOperator : Int
        var operand : String
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            indexOperator = operationsToReduce.firstIndex(of: "x") ?? -1
            if indexOperator == -1 {
                indexOperator = operationsToReduce.firstIndex(of: "/") ?? -1
            }
            if indexOperator != -1 {
                let left = Double(operationsToReduce[indexOperator - 1])
                let right = Double(operationsToReduce[indexOperator + 1])
                operand = operationsToReduce[indexOperator]
                switch operand {
                case "x" : result = Double(left! * right!)
                case "/" : result = Double(left! / right!)
                default : break
                }
                operationsToReduce.removeSubrange(indexOperator - 1..<indexOperator + 2)
                operationsToReduce.insert(String(result), at: indexOperator - 1)
            } else {
                indexOperator = operationsToReduce.firstIndex(of: "+") ?? -1
                if indexOperator == -1 {
                    indexOperator = operationsToReduce.firstIndex(of: "-") ?? -1
                }
                if indexOperator != -1 {
                    let left = Double(operationsToReduce[indexOperator - 1])
                    let right = Double(operationsToReduce[indexOperator + 1])
                    operand = operationsToReduce[indexOperator]
                    switch operand {
                    case "+" : result = Double(left! + right!)
                    case "-" : result = Double(left! - right!)
                    default : break
                    }
                    operationsToReduce.removeSubrange(indexOperator - 1..<indexOperator + 2)
                    operationsToReduce.insert(String(result), at: indexOperator - 1)
                }
            }
        }
        textView.text.append(" = \(operationsToReduce.first!)")
        
    }
    
    
    
    
    enum alertOperatorEnum {
        case operatorIsAlreadyInPlace, startANewCalcul,enterACorrectExpression
        
    }
    /// The operator alert that changes according to the enum
    func alertOperator(_ alertOperator : alertOperatorEnum ){
        let alertVC = UIAlertController(title: "Zéro!", message: stringMessageAlert(alertOperator), preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
    /// The switch of the different alert messages
    func stringMessageAlert(_ alertOperator :  alertOperatorEnum ) -> String {
        let message = ["Un operateur est déja mis !","Démarrez un nouveau calcul !","Entrez une expression correcte !"]
        switch  alertOperator  {
        case .operatorIsAlreadyInPlace : return message[0]
        case .startANewCalcul : return message[1]
        case .enterACorrectExpression : return message[2]
        }
    }
}
