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
    
    // the different notifications that allow you to update the text displayed on the screen or display error notifications.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = Notification.Name(rawValue:"updateTextView")
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextView), name: name, object: nil)
        
        let notifCorrect = Notification.Name(rawValue:"error")
        NotificationCenter.default.addObserver(self, selector: #selector(errorHandler), name: notifCorrect, object: nil)
        
    }
    
    @objc func errorHandler(_ notification : Notification) {
        if let message = notification.userInfo?["message"] as? String {
            alertOperator(message) } else
        {alertOperator("erreur")  }
    }
    
    
    @objc func updateTextView() {
        textView.text = calcul.calculString
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calcul.addNumber(number : numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        
        calcul.addOperator(operation:"+")
        
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        
        calcul.addOperator(operation:"-")
        
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        calcul.addOperator(operation:"x")
        
    }
    
    @IBAction func tappedDivisionButton(_ sender: Any) {
        calcul.addOperator(operation:"/")
        
    }
    
    @IBAction func tappedAC(_ sender: UIButton) {
        calcul.cleanNumber()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if calcul.expressionHaveResult {
            calcul.calculString = ""
        } else {
            calcul.orderOfOperationAndCalculate()
        }
    }
    
    enum alertOperatorEnum {
        case operatorIsAlreadyInPlace, startANewCalcul,enterACorrectExpression, notBeginWithOperator
        
    }
    
    /// The operator alert that changes according to the enum
    func alertOperator(_ alertOperator : String ){
        let alertVC = UIAlertController(title: "Erreur ! 😥", message: alertOperator, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
