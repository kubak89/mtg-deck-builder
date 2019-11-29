//
//  CardsListView.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 08/11/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import Foundation
import RxSwift

protocol CardsListViewIntents {
    var downloadCardsIntent: Observable<Any> { get }
    var searchCardsIntent: Observable<String> { get }
}
