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
//    let viewStateObservable: Observable<CardsListViewState> = PublishSubject()
//    let cardsService: CardsRepository
    
    init(view: CardsListView, initialState: CardsListViewState) {
        self.view = view
        
//        Observable.merge(
//            view.downloadCardsIntent.flatMap { (a: Any) in
//                cardsService.rxSearchCards(name: "")
//                CardsDownloaded(cards: a)
//        })
    }
}
