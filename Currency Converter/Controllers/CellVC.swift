//
//  TableViewCell.swift
//  Currency Converter
//
//  Created by Ilya on 12.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class CellVC: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func setup(name: String?, value: Double?) {
        nameLabel.text = name
        valueLabel.text = String(format: "%f", value ?? "0") + " EUR"
    }
}
