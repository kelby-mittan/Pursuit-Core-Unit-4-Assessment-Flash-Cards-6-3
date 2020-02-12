//
//  SearchCardsController.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchCardsController: UIViewController {
    
    public var dataPersistence: DataPersistence<Card>!
    
    private let searchView = SearchView()
    
    private var isShowingFact = false
    
    override func loadView() {
        view = searchView
    }
    
    private var flashCards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.searchBar.delegate = self
        
        searchView.backgroundColor = .systemBackground
        searchView.collectionView.register(CardsCell.self, forCellWithReuseIdentifier: "searchCell")
        getLocalCards()
        
    }
    
    // Function not being used because of problems with the API
    //    private func getCards() {
    //        CardAPIClient.fetchCards { [weak self] (result) in
    //            switch result {
    //            case .failure(let error):
    //                print("error \(error)")
    //            case .success(let cards):
    //                self?.flashCards = cards
    //            }
    //        }
    //
    //    }
    
    private func getLocalCards() {
        
        do {
            flashCards = try FlashCardService.fetchFlashCards()
        } catch {
            print("couldn't get flash cards")
        }
    }
    
}


extension SearchCardsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? CardsCell else {
            fatalError("could not deque")
        }
        cell.backgroundColor = .systemBackground
        let card = flashCards[indexPath.row]

        // Would Really like to know why this doesn't work.
//        if dataPersistence.hasItemBeenSaved(card) {
//            cell.addButton.isEnabled = false
//        }
        
        cell.currentCard = card
        cell.isSavedCell = true
        cell.delegate = self
        cell.configureCell(for: card)
        return cell
    }
}

extension SearchCardsController: UICollectionViewDelegateFlowLayout {
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

extension SearchCardsController: CardCellDelegate {
    
    func selectedButton(_ cell: CardsCell, card: Card) {
        
        if dataPersistence.hasItemBeenSaved(card) {
            showAlert(title: "Oops", message: "You've already added \"\(card.quizTitle)\" to your collection")
        } else {
            do {
                try dataPersistence.createItem(card)
                showAlert(title: "Great", message: "\"\(card.quizTitle)\" has been added.")
            } catch {
                print("could not create")
                showAlert(title: "oops", message: "could not add flash card")
            }
        }
    }
    
}

extension SearchCardsController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            getLocalCards()
            return
        }
        flashCards = flashCards.filter { $0.quizTitle.lowercased().contains(searchText.lowercased()) }
    }
}
