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
    var searchCardsIntent: Observable<String> = PublishSubject()

    private var cardsArray: [Card] = []

    lazy private var cardsContainer = CardsListContainer(cardsListController: self)

    lazy private var cardsView = cardsContainer.container.resolve(CardsListView.self)!

    lazy private var cardsListPresenter = CardsListPresenter(view: self, cardsService: cardsService, initialState: CardsListViewState())
    private let cardsService = CardsRepository()

    private var disposables = CompositeDisposable()

    override func viewDidLoad() {
        super.viewDidLoad()

        cardsView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.allEditingEvents)

        disposables.insert(
                cardsListPresenter.getViewStateObservable().subscribe { viewState in
                    if (viewState.element != nil) {
                        self.render(viewState: viewState.element!)
                    }
                })
    }

    private func render(viewState: CardsListViewState) {
        let newCards: [Card] = viewState.cardsList
        self.cardsArray = newCards
        DispatchQueue.main.async {
            self.cardsView.resultsView.reloadData()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        disposables.dispose()
    }

    @objc func textFieldDidChange(textField: UITextField) {
        (searchCardsIntent as! PublishSubject<String>).onNext(textField.text ?? "")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(cardsArray[indexPath.row])"
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action:  #selector (self.openCardDetails (_:))))
        return cell
    }
    
    @objc func openCardDetails(_ sender: UITapGestureRecognizer) {
        let cardDetailsController = CardsDetailsController()
        cardDetailsController.card = cardsArray[sender.view!.tag]
    
        cardDetailsController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(cardDetailsController,animated:true)
    }
}
