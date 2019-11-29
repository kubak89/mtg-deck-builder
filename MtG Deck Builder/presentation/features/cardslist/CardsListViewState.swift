//
//  CardsListViewState.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 08/11/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import Foundation

struct CardsListViewState {
    let cardsList: [Card]
    let downloadError: Error?

    init(cardsList: [Card] = [], downloadError: Error? = nil) {
        self.cardsList = cardsList
        self.downloadError = downloadError
    }

    func copy(newCards: [Card]? = nil, newDownloadError: Error? = nil) -> CardsListViewState {
        return CardsListViewState(cardsList: newCards ?? cardsList, downloadError: newDownloadError ?? downloadError)
    }
}

protocol CardsListPartialState {
}

struct CardsDownloaded: CardsListPartialState {
    let cards: [Card]
}
