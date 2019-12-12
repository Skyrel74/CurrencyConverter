//
//  ViewController.swift
//  Currency Converter
//
//  Created by Ilya on 11.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //var activeCurrency:Double = 0;
    
    //Objects from storyboard
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var converterContainer: UIView!
    @IBOutlet weak var favoriteContainer: UIView!
    @IBOutlet weak var currencyTable: UITableView!
    
    //Switch action
    @IBAction func `switch`(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
        case 0:
            tableContainer.alpha = 1
            converterContainer.alpha = 0
            favoriteContainer.alpha = 0
            break;
        case 1:
            tableContainer.alpha = 0
            converterContainer.alpha = 1
            favoriteContainer.alpha = 0
            break;
        case 2:
            tableContainer.alpha = 0
            converterContainer.alpha = 0
            favoriteContainer.alpha = 1
            break;
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.loadCurrency { currencyArray in
            Currency.shared = currencyArray
            self.currencyTable.reloadData()
        }
        
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Currency.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellVC") as! CellVC
        let currency = Currency.shared[indexPath.row]
        cell.setup(name: currency.name, value: currency.proportion)
        return cell
    }
}
