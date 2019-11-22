//
//  MtgCard.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 07/06/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import Foundation
import RxSwift

struct Card: Codable {
    let name: String
    let names: [String]?
    let manaCost: String?
    let cmc: Int
    let colors, colorIdentity: [String]
    let type: String
    let supertypes, types, subtypes: [String]
    let rarity, cardSet, artist: String
    let text: String?
    let number: String
    let power: String?
    let toughness: String?
    let layout: String
    let multiverseid: Int?
    let imageURL: String?
    let rulings: [Ruling]?
    let foreignNames: [ForeignName]?
    let printings: [String]?
    let originalText: String?
    let originalType: String?
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name, names, manaCost, cmc, colors, colorIdentity, type, supertypes, types, subtypes, rarity
        case cardSet = "set"
        case text, artist, number, power, toughness, layout, multiverseid
        case imageURL = "imageUrl"
        case rulings, foreignNames, printings, originalText, originalType, id
    }
    
    
}

// MARK: - ForeignName
struct ForeignName: Codable {
    let name, language: String
    let multiverseid: Int
}

// MARK: - Ruling
struct Ruling: Codable {
    let date, text: String
}

