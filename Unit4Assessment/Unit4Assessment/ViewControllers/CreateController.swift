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
    
    override func loadView() {
        view = createVC
    }
    
    public var dataPersistence: DataPersistence<Card>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Create Flash Card"
        let createBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createFlashCard(_:)))
        self.navigationItem.rightBarButtonItem  = createBarButtonItem

        createVC.backgroundColor = .systemIndigo
    }
    

    @objc func createFlashCard(_ sender: UIBarButtonItem){
        print("clicked")
        sender.isEnabled = false
        
        do {
//            try dataPersistence.createItem(createdCard)
            
        } catch {
            print("could not save")
            showAlert(title: "Sorry", message: "This Flash Card could not be favorited")
        }
        
    }

}
