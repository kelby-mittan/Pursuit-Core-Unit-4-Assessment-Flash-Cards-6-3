//
//  Unit4AssessmentTests.swift
//  Unit4AssessmentTests
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import XCTest
@testable import Unit4Assessment

class Unit4AssessmentTests: XCTestCase {

    func testFirstCard() {
        
        let jsonData = """
        {
        "cardListType": "q and a",
        "apiVersion": "1.2.3",
        "cards": [
            {
                "id": "1",
                "cardTitle": "What is the difference between a synchronous & an asynchronous task?",
                "facts": [
                    "Synchronous: waits until the task have completed.",
                    "Asynchronous: completes a task in the background and can notify you when complete."
                ]
            }
            ]}
        """.data(using: .utf8)!
        
        struct CardData: Codable {
            let cardListType: String
            let cards: [Card]
        }
        
        struct Card: Codable {
            let id: String
            let cardTitle: String
            let facts: [String]
        }
        // act
        let expectedTitle = "What is the difference between a synchronous & an asynchronous task?"
        
        do {
            let cardSearch = try JSONDecoder().decode(CardData.self, from: jsonData)
            let gotTitle = cardSearch.cards.first?.cardTitle ?? ""
            XCTAssertEqual(expectedTitle, gotTitle)
        } catch {
            XCTFail("decoding error: \(error)")
        }

        
    }
    
    func testAPIClient() {
        CardAPIClient.fetchCards { (result) in
            switch result {
            case .failure(let error):
                XCTFail("decoding error: \(error)")
            case .success(let cards):
                XCTAssertEqual(cards.count, 52)
            }
        }
    }

}
