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
        
        createBarButtonItem.isEnabled = true
        
        createVC.backgroundColor = .lightGray
    }
    
    
    @objc func createFlashCard(_ sender: UIBarButtonItem){
        
        let cardsVC = CardsController()
        cardsVC.dataPersistence = dataPersistence
        
        cardFacts.append(cardFact1)
        cardFacts.append(cardFact2)
        
        if !titleForCard.isEmpty && cardFact1 != "" && cardFact2 != "" {
            
            let createdCard = Card(id: "0", quizTitle: titleForCard, facts: cardFacts)
            
            do {
                try dataPersistence.createItem(createdCard)
                
            } catch {
                showAlert(title: "Sorry", message: "This Flash Card could not be saved")
            }
            resetUI()
//            navigationController?.pushViewController(cardsVC, animated: true)
        } else {
            showAlert(title: "Oops", message: "Please enter a title as well as two facts!!")
        }
        
    }
    
    private func resetUI() {
        createVC.cardTitleTextField.text = ""
        createVC.cardFact1TextView.text = ""
        createVC.cardFact2TextView.text = ""
        createVC.cardTitleTextField.resignFirstResponder()
        createVC.cardFact1TextView.resignFirstResponder()
        createVC.cardFact2TextView.resignFirstResponder()
        createVC.placeHolderLabel1.isHidden = false
        createVC.placeHolderLabel2.isHidden = false
        showAlert(title: "Cool", message: "This Flash Card has been created")
    }
    
}

extension CreateController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleForCard = textField.text ?? ""
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        titleForCard = textField.text ?? ""
    }
}

extension CreateController: UITextViewDelegate {
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if textView == createVC.cardFact1TextView {
            cardFact1 = textView.text
            textView.resignFirstResponder()
            return true
        } else {
            cardFact2 = textView.text
            textView.resignFirstResponder()
            return true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == createVC.cardFact1TextView {
            createVC.placeHolderLabel1.isHidden = true
            cardFact1 = textView.text
        } else {
            createVC.placeHolderLabel2.isHidden = true
            cardFact2 = textView.text
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
}
