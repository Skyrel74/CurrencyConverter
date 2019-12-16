//
//  TableViewController.swift
//  Currency Converter
//
//  Created by Ilya on 13.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit
import Network

class TableViewController: UIViewController {
    
    let monitor = NWPathMonitor()

    @IBOutlet weak var currencyTable: UITableView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoreDataManager.clearData()
        API.loadCurrency { currencyArray in
            self.currencyTable.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
            self.loadIndicator.stopAnimating()
        }
        
        /*monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Yay! We have internet!")
            }else{
                print("NO")
            }
        }*/
        
        CoreDataManager.fetch()
        CoreDataManager.shared.sort { ($0.value(forKey: "name") as! String) < ($1.value(forKey: "name") as! String) }
        self.currencyTable.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
        self.loadIndicator.stopAnimating()
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

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellVC") as! CellVC
        let currency = CoreDataManager.shared[indexPath.row]
        cell.setup(name: currency.value(forKey: "name") as? String, value: currency.value(forKey: "proportion") as? Double)
        return cell
    }
}
