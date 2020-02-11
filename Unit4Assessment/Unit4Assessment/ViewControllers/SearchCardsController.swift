//
//  SearchCardsController.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCardsController: UIViewController {

    private let searchView = SearchView()
    
    private var isShowingFact = false
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        
        searchView.backgroundColor = .systemBackground
        searchView.collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "searchCell")
    }
    


}


extension SearchCardsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not deque")
        }
        
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    
}

extension SearchCardsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.3
        let itemWidth: CGFloat = maxSize.width * 0.85
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not deque")
        }
        
        cell.animate()
        print("did select")
        let duration: Double = 1.5
        if isShowingFact {
            UIView.transition(with: cell, duration: duration, options: [.transitionFlipFromRight], animations: {
                cell.cardTitle.alpha = 1.0
                cell.cardFacts.alpha = 0.0
                print("animate 1")
                self.isShowingFact.toggle()
            }, completion: nil)
        } else {
            UIView.transition(with: cell, duration: duration, options: [.transitionFlipFromRight], animations: {
                cell.cardTitle.alpha = 0.0
                cell.cardFacts.alpha = 1.0
                cell.backgroundColor = .red
                print("animate 2")
                self.isShowingFact.toggle()
            }, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
