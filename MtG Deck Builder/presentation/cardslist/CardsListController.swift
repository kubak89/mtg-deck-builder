//
//  ViewController.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 07/06/2019.
//  Copyright © 2019 Jakub Komorowski. All rights reserved.
//

import UIKit
import SnapKit

class CardsListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let searchTextField: UITextField = UITextField()
    private let resultsView: UITableView = UITableView()
    
    private var cardsArray: [Card] = []
    
    private let cardsService = CardsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchView()
        initResultsView()
        
        cardsService.rxSearchCards(name: "Wizard").subscribe(
            onSuccess: { (cards: [Card]) -> Void in
                print(cards)
                self.cardsArray += cards.self
                self.resultsView.reloadData()
        },
            onError: { (error: Error) -> Void in
                let alert = UIAlertController.init(title: "Error downloading cards", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)}
        )
    }
    
    private func initSearchView() {
        view.addSubview(searchTextField)
        
        searchTextField.font = UIFont.systemFont(ofSize: 25)
        searchTextField.snp.makeConstraints{
            (make) -> Void in
            make.margins.topMargin.equalTo(15)
            make.left.equalTo(view).inset(15)
            make.right.equalTo(view).inset(15)
            make.height.equalTo(100)
        }
        searchTextField.placeholder = "Search"
    }
    
    private func initResultsView() {
        view.addSubview(resultsView)
        
        resultsView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        resultsView.dataSource = self
        resultsView.delegate = self
        resultsView.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
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
