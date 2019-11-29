//
// Created by Jakub Komorowski on 29/11/2019.
// Copyright (c) 2019 Jakub Komorowski. All rights reserved.
//

import Foundation
import Swinject

class CardsListContainer {
    let container: Container

    init(cardsListController: CardsListController) {
        container = Container()

        container.register(CardsListViewIntents.self) { _ in
            cardsListController
        }

        container.register(CardsListView.self) { _ in
            CardsListView(mainView: cardsListController.view, tableViewDataSource: cardsListController, tableViewDelegate: cardsListController)
        }
    }
}