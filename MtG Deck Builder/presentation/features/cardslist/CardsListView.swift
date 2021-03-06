//
// Created by Jakub Komorowski on 29/11/2019.
// Copyright (c) 2019 Jakub Komorowski. All rights reserved.
//

import Foundation
import SnapKit

class CardsListView {
    private let tableViewDataSource: UITableViewDataSource
    private let tableViewDelegate: UITableViewDelegate

    let searchTextField: UITextField = UITextField()
    let resultsView: UITableView = UITableView()

    init(mainView: UIView, tableViewDataSource: UITableViewDataSource, tableViewDelegate: UITableViewDelegate) {
        self.tableViewDataSource = tableViewDataSource
        self.tableViewDelegate = tableViewDelegate
        
        //TODO: Add loading view

        initSearchView(view: mainView)
        initResultsView(view: mainView)
    }

    private func initSearchView(view: UIView) {
        view.addSubview(searchTextField)
        
        //TODO: Fix positioning so the search view isn't obscured by the nav bar

        searchTextField.font = UIFont.systemFont(ofSize: 25)
        searchTextField.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view).inset(15)
            make.right.equalTo(view).inset(15)
            make.height.equalTo(100)
        }
        searchTextField.placeholder = "Search"
    }

    private func initResultsView(view: UIView) {
        view.addSubview(resultsView)

        resultsView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        resultsView.dataSource = tableViewDataSource
        resultsView.delegate = tableViewDelegate
        resultsView.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
}
