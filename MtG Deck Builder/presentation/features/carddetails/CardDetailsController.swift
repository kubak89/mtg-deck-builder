//
//  CardDetailsController.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 20/03/2020.
//  Copyright © 2020 Jakub Komorowski. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CardsDetailsController: UIViewController {
    var card: Card?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        
        let textView = UITextView()
        textView.text = card?.name
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(view).inset(15)
                make.left.equalTo(view).inset(15)
                make.right.equalTo(view).inset(15)
                make.height.equalTo(100)
            }
        }
}
