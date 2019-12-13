//
//  TableViewController.swift
//  Currency Converter
//
//  Created by Ilya on 13.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var currencyTable: UITableView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        API.loadCurrency { currencyArray in
            self.loadIndicator.startAnimating()
            Currency.shared = currencyArray
            self.currencyTable.reloadData()
            self.loadIndicator.stopAnimating()
        }
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Currency.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellVC") as! CellVC
        let currency = Currency.shared[indexPath.row]
        cell.setup(name: currency.name, value: currency.proportion)
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
