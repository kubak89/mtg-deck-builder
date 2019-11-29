//
//  CardsListPresenter.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 08/11/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import Foundation
import RxSwift

class CardsListPresenter {
    let view: CardsListView
    let cardsService: CardsRepository
    let initialState: CardsListViewState
    
    init(view: CardsListView, cardsRepository: CardsRepository, initialState: CardsListViewState) {
        self.view = view
        self.cardsService = cardsRepository
        self.initialState = initialState
    }
    
    func getViewStateObservable() -> Observable<CardsListViewState> {
        return
            Observable.merge(downloadCards())
                .scan(
                    initialState,
                    accumulator: { (viewState: CardsListViewState, partialState: CardsListPartialState) -> CardsListViewState in
                        if(partialState is CardsDownloaded) {
                            return viewState.copy(newCards: (partialState as! CardsDownloaded).cards)
                        } else {
                            throw NSError()
                        }
                })
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
