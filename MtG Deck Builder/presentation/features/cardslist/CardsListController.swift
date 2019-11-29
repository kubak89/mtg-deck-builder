//
//  ViewController.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 07/06/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class CardsListController: UIViewController, UITableViewDelegate, UITableViewDataSource, CardsListViewIntents {
    var downloadCardsIntent: Observable<Any> = Observable.just(0)

    private var cardsArray: [Card] = []

    lazy private var cardsContainer = CardsListContainer(cardsListController: self)

    lazy private var cardsView = cardsContainer.container.resolve(CardsListView.self)!

    lazy private var cardsListPresenter = CardsListPresenter(view: self, cardsService: cardsService, initialState: CardsListViewState())

    private let cardsService = CardsRepository()
    private var disposables = CompositeDisposable()

    override func viewDidLoad() {
        super.viewDidLoad()

        disposables.insert(
                cardsListPresenter.getViewStateObservable().subscribe { viewState in
                    guard let newCards = viewState.element?.cardsList else {
                        return
                    }
                    self.cardsArray = newCards
                    self.cardsView.resultsView.reloadData()
                })
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        disposables.dispose()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(cardsArray[indexPath.row])"
        return cell
    }
}
