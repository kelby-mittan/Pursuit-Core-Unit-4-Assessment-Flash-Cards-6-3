//
//  CreateController.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateController: UIViewController {
    
    private let createVC = CreateView()
    
    private var titleForCard = ""
    private var cardFact1 = ""
    private var cardFact2 = ""
    private var cardFacts = [String]()
    
    override func loadView() {
        view = createVC
    }
    
    public var dataPersistence: DataPersistence<Card>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createVC.cardTitleTextField.delegate = self
        createVC.cardFact1TextView.delegate = self
        createVC.cardFact2TextView.delegate = self
        
        navigationItem.title = "Create Flash Card"
        let createBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createFlashCard(_:)))
        self.navigationItem.rightBarButtonItem  = createBarButtonItem
        //        createBarButtonItem.isEnabled = false
        createVC.backgroundColor = .systemIndigo
    }
    
    
    @objc func createFlashCard(_ sender: UIBarButtonItem){
       
        cardFacts.append(cardFact1)
        cardFacts.append(cardFact2)
        
        if !cardFact1.isEmpty && cardFacts.count == 2 {
            sender.isEnabled = false
            
            let createdCard = Card(id: "1", quizTitle: titleForCard, facts: cardFacts)
            
            do {
                try dataPersistence.createItem(createdCard)
                
            } catch {
                showAlert(title: "Sorry", message: "This Flash Card could not be saved")
            }
            showAlert(title: "Great", message: "This card has been added!!!")
        } else {
            showAlert(title: "Oops", message: "Please enter a title as well as two facts!!")
        }
        
    }
    
}

extension CreateController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleForCard = textField.text ?? ""
        textField.resignFirstResponder()
        return true
    }
}

extension CreateController: UITextViewDelegate {
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if textView == createVC.cardFact1TextView {
            cardFact1 = textView.text
            textView.text = ""
            textView.resignFirstResponder()
            return true
        } else {
            cardFact2 = textView.text
            textView.text = ""
            textView.resignFirstResponder()
            return true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == createVC.cardFact1TextView {
            cardFact1 = textView.text
        } else {
            cardFact2 = textView.text
        }
        
    }
    
}
