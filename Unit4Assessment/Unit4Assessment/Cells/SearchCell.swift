//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol SearchCellDelegate: AnyObject {
    func selectedAddButton(_ savedArticleCell: SearchCell)
}

class SearchCell: UICollectionViewCell {
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    public lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 5
        label.isUserInteractionEnabled = true
        label.text = "Testing the title for the card"
        return label
    }()
    
    public lazy var cardFacts: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 5
        label.isUserInteractionEnabled = true
        label.alpha = 0
        label.text = "Testing the facts for the card"
        return label
    }()
    
    weak var delegate: SearchCellDelegate?
    
    public var isShowingFact = false
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupAddButtonConstraints()
        setupCardTitleConstraints()
        addGestureRecognizer(longPressGesture)
    }
    
    private func setupAddButtonConstraints() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupCardTitleConstraints() {
        addSubview(cardTitle)
        cardTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            cardTitle.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            cardTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func addButtonPressed(_ sender: UIButton) {
        delegate?.selectedAddButton(self)
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began || gesture.state == .changed {

            return
        }
        isShowingFact.toggle()
        animate()
    }
    
    public func animate() {
        let duration: Double = 1.5
        if isShowingFact {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.cardTitle.alpha = 1.0
                self.cardFacts.alpha = 0.0
                self.isShowingFact.toggle()
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.cardTitle.alpha = 0.0
                self.cardFacts.alpha = 1.0
                self.isShowingFact.toggle()
            }, completion: nil)
        }
    }
    
}
