//
//  CardsAPIClient.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
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

