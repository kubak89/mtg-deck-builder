//
//  CellView.swift
//  MtG Deck Builder
//
//  Created by Jakub Komorowski on 17/01/2020.
//  Copyright © 2020 Jakub Komorowski. All rights reserved.
//

import Foundation
import SnapKit

class CellView : UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
