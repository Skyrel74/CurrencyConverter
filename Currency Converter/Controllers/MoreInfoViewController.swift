//
//  MoreInfoViewController.swift
//  Currency Converter
//
//  Created by Ilya on 13.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit
import Charts

class MoreInfoViewController: UIViewController {
    
    var indexPathRow = Int()
    var rates = [Currency]()
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        API.Symbol = CoreDataManager.shared[indexPathRow].value(forKey: "name") as! String
        API.chartLoad { currencyArray in
            self.lineChartView.alpha = 0
            self.loadIndicator.startAnimating()
            self.rates = currencyArray
            self.setChartValues()
            self.loadIndicator.stopAnimating()
            self.lineChartView.alpha = 1
            self.infoLabel.text = CoreDataManager.shared[self.indexPathRow].value(forKey: "name") as! String + " exchange EUR in half year"
        }
    }
    
    func setChartValues() {
        let count: Int = rates.count
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = rates[i].proportion
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(values: values, label: CoreDataManager.shared[self.indexPathRow].value(forKey: "name") as? String)
        let data = LineChartData(dataSet: set1)
        
        self.lineChartView.data = data
    }
}
