//
//  CreateView.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateView: UIView {
    
    public lazy var cardTitleTextField: UITextField = {
        let textField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        textField.placeholder = "enter title for card here"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    public lazy var cardFact1TextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
        textView.textAlignment = NSTextAlignment.justified
        textView.autocorrectionType = .no
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.keyboardType = .default
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    public lazy var cardFact2TextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: 20, y: 100, width: 300, height: 100))
        textView.textAlignment = NSTextAlignment.justified
        textView.autocorrectionType = .no
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.keyboardType = .default
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupTitleTextField()
        setupFact1TV()
        setupFact2TV()
    }
    
    
    private func setupTitleTextField() {
        addSubview(cardTitleTextField)
        cardTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardTitleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            cardTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardTitleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupFact1TV() {
        addSubview(cardFact1TextView)
        cardFact1TextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardFact1TextView.topAnchor.constraint(equalTo: cardTitleTextField.bottomAnchor, constant: 20),
            cardFact1TextView.leadingAnchor.constraint(equalTo: cardTitleTextField.leadingAnchor),
            cardFact1TextView.trailingAnchor.constraint(equalTo: cardTitleTextField.trailingAnchor),
            cardFact1TextView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupFact2TV() {
        addSubview(cardFact2TextView)
        cardFact2TextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardFact2TextView.topAnchor.constraint(equalTo: cardFact1TextView.bottomAnchor, constant: 20),
            cardFact2TextView.leadingAnchor.constraint(equalTo: cardTitleTextField.leadingAnchor),
            cardFact2TextView.trailingAnchor.constraint(equalTo: cardTitleTextField.trailingAnchor),
            cardFact2TextView.heightAnchor.constraint(equalTo: cardFact1TextView.heightAnchor)
        ])
    }
    
}
