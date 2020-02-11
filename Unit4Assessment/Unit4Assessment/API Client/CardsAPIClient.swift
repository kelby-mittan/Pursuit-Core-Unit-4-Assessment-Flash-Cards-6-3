//
//  CardsAPIClient.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import UIKit
import NetworkHelper

struct CardAPIClient {
    static func fetchCards(completion: @escaping (Result<[Card], AppError>) -> ()) {
        let cardEndpointURL = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
        
        guard let url = URL(string: cardEndpointURL) else {
            completion(.failure(.badURL(cardEndpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let cardData = try JSONDecoder().decode(CardData.self, from: data)
                    let cards = cardData.cards
                    completion(.success(cards))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

