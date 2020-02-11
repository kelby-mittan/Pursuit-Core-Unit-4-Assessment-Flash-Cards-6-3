//
//  CardsController.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CardsController: UIViewController {

    private let cardsView = CardsView()
    
    override func loadView() {
        view = cardsView
    }
    
    private var savedFlashCards = [Card]() {
        didSet {
            cardsView.collectionView.reloadData()
            if savedFlashCards.isEmpty {
                cardsView.collectionView.backgroundView = EmptyView(title: "Saved Flash Cards", message: "There are currently no saved Flash Cards. Create a Flash Card or add a Flash Card.")
            } else {
                cardsView.collectionView.backgroundView = nil
            }
        }
    }
    
    public var dataPersistence: DataPersistence<Card>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardsView.collectionView.dataSource = self
        cardsView.collectionView.delegate = self
        cardsView.backgroundColor = .systemBackground
        cardsView.collectionView.register(CardsCell.self, forCellWithReuseIdentifier: "cardCell")
        addBackgroundGradient()
        loadCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadCards()
    }
    
    private func loadCards() {
        do {
            savedFlashCards = try dataPersistence.loadItems()
        } catch {
            print("could not load cards")
        }
    }
    
    private func addBackgroundGradient() {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = view.frame.size
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        cardsView.collectionView.backgroundView = collectionViewBackgroundView
        cardsView.collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    

}


extension CardsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedFlashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardsCell else {
            fatalError("could not deque")
        }
        let card = savedFlashCards[indexPath.row]
        cell.delegate = self
        cell.currentCard = card
        cell.configureCell(for: card)
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    
}


extension CardsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.27
        let itemWidth: CGFloat = maxSize.width * 0.85
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
}

extension CardsController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCards()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadCards()
    }
    
}

extension CardsController: CardCellDelegate {
    func selectedButton(_ cell: CardsCell, card: Card) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCard(card)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    private func deleteCard(_ card: Card) {
        
        guard let index = savedFlashCards.firstIndex(of: card) else {
            return
        }
        savedFlashCards.remove(at: index)
        do {
            try self.dataPersistence.deleteItem(at: index)
        } catch {
            showAlert(title: "Oops", message: "could not delete flash card")
        }
    }
    
}
