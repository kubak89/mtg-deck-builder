//
//  CardsListPresenter.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 08/11/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import Foundation
import RxSwift
import Swinject

class CardsListPresenter {
    let view: CardsListViewIntents
    let cardsService: CardsRepository
    let initialState: CardsListViewState

    init(view: CardsListViewIntents, cardsService: CardsRepository, initialState: CardsListViewState) {
        self.view = view
        self.cardsService = cardsService
        self.initialState = initialState
    }

    func getViewStateObservable() -> Observable<CardsListViewState> {
        return Observable.merge(downloadCards()).scan(initialState, accumulator: reduce)
    }

    private func reduce(previousViewState: CardsListViewState, partialState: CardsListPartialState) throws -> CardsListViewState {
        if (partialState is CardsDownloaded) {
            return previousViewState.copy(newCards: (partialState as! CardsDownloaded).cards)
        } else {
            throw NSError()
        }
    }

    private func downloadCards() -> Observable<CardsListPartialState> {
        return self.view.downloadCardsIntent.flatMap { (a: Any) -> Observable<CardsListPartialState> in
            self.cardsService
                    .rxSearchCards(name: "Wizard")
                    .map { (cards: [Card]) -> CardsListPartialState in
                        CardsDownloaded(cards: cards)
                    }
                    .asObservable()
        }
    }
}
