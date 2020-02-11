//
//  Card.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct CardData: Codable & Equatable {
    let cardListType: String
    let cards: [Card]
}

struct Card: Codable & Equatable {
    let id: String
//    let cardTitle: String
    let quizTitle: String
    let facts: [String]
}
