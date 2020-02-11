//
//  FlashCardsTabBarController.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class FlashCardsTabBarController: UITabBarController {

    
    
    private lazy var cardsVC: CardsController = {
        let viewController = CardsController()
        viewController.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "folder"), tag: 0)
        return viewController
    }()
    
    private lazy var createCardsVC: CreateController = {
        let viewController = CreateController()
        viewController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "pencil.and.ellipsis.rectangle"), tag: 1)
        return viewController
    }()
    
    private lazy var searchCardsVC: SearchCardsController = {
        let viewController = SearchCardsController()
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [cardsVC,createCardsVC,searchCardsVC]
    }
    

}
