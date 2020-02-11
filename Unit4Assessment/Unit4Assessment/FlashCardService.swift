//
//  FlashCardService.swift
//  Unit4Assessment
//
//  Created by Kelby Mittan on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

public enum AppleServiceError: Error {
  case resourcePathDoesNotExist
  case contentsNotFound
  case decodingError(Error)
}

final class FlashCardService {
  public static func fetchFlashCards() throws -> [Card] {
    guard let path = Bundle.main.path(forResource: "flashcard", ofType: "json") else {
      throw AppleServiceError.resourcePathDoesNotExist
    }
    guard let json = FileManager.default.contents(atPath: path) else {
      throw AppleServiceError.contentsNotFound
    }
    do {
      let stocks = try JSONDecoder().decode([Card].self, from: json)
      return stocks
    } catch {
      throw AppleServiceError.decodingError(error)
    }
  }
}
