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
    
    public var dataPersistence: DataPersistence<Card>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardsView.collectionView.dataSource = self
        cardsView.collectionView.delegate = self
        
        cardsView.collectionView.register(CardsCell.self, forCellWithReuseIdentifier: "cardCell")
        cardsView.backgroundColor = .orange
    }
    

}


extension CardsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardsCell else {
            fatalError("could not deque")
        }
        
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    
}

extension CardsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemHeight: CGFloat = maxSize.height * 0.3
        let itemWidth: CGFloat = maxSize.width * 0.85
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardsCell else {
            fatalError("could not deque")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
