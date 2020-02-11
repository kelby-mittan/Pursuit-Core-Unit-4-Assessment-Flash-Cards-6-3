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
        textField.placeholder = "Enter text here"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.keyboardType = .default
        textField.returnKeyType = .done
//        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    public lazy var cardFact1TextField: UITextView = {
        let textV = UITextView()
        return textV
    }()
    
    public lazy var cardFact2TextField: UITextView = {
        let textField = UITextView()
        return textField
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
}
