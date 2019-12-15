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
            self.currencyTable.reloadData()
            self.loadIndicator.stopAnimating()
        }
    }

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellVC") as! CellVC
        let currency = CoreDataManager.shared[indexPath.row]
        cell.setup(name: currency.value(forKey: "name") as? String, value: currency.value(forKey: "proportion") as? Double)
        return cell
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chartsSegue" {
            if let nextVC = segue.destination as? MoreInfoViewController {
                nextVC.indexPathRow = self.currencyTable.indexPathForSelectedRow!.row
            }
        }
    }
}
