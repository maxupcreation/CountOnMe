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
    
    var calcul = Calcul()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = Notification.Name(rawValue:"updateString")
        NotificationCenter.default.addObserver(self, selector: #selector(tappedEqualButton), name: name, object: nil)
    }
    
    func updateScreen() {
        textView.text = calcul.calculString
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        if calcul.expressionHaveResult {
            textView.text = numberText
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calcul.canAddOperator {
            textView.text.append(" + ")
        } else {
            alertOperator(.operatorIsAlreadyInPlace)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calcul.canAddOperator {
            textView.text.append(" - ")
        } else {
            alertOperator(.operatorIsAlreadyInPlace)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        if calcul.canAddOperator {
            textView.text.append(" x ")
        } else {
            alertOperator(.operatorIsAlreadyInPlace)
        }
        
    }
    
    @IBAction func tappedDivisionButton(_ sender: Any) {
        if calcul.canAddOperator {
            textView.text.append(" / ")
        } else {
            alertOperator(.operatorIsAlreadyInPlace)
        }
        
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        
        guard calcul.expressionIsCorrect else {
            alertOperator(.enterACorrectExpression)
            return
        }
        
        guard calcul.expressionHaveEnoughElement else {
            alertOperator(.startANewCalcul)
            return
        }
        
        calcul.OrderOfOperationAndCalculate()
        
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
