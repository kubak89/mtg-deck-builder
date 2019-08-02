//
//  CardsResponse.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 02/08/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import Foundation

struct CardsResponse : Codable {
    let cards: [Card]
}
