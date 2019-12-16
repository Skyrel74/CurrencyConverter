//
//  API.swift
//  Currency Converter
//
//  Created by Ilya on 11.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import Foundation
import CoreData

typealias JSON = [String : Any]

enum API {
    
    static var API_KEY: String { return "6923be495780e0cb87df2167ed5de68e" }
    
    static var dataURL: String {
        return "http://data.fixer.io/api/latest?access_key=\(API_KEY)"
    }
    
    static func loadCurrency(completion: @escaping ([NSManagedObject]) -> Void) {
        let url = URL(string: dataURL)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSON
                else { return }
            let rates = json["rates"] as! NSDictionary
            CoreDataManager.clearData()
            for currency_ in rates {
                CoreDataManager.save(name: currency_.key as! String, proportion: currency_.value as! Double)
            }
            CoreDataManager.shared.sort { ($0.value(forKey: "name") as! String) < ($1.value(forKey: "name") as! String) }
            DispatchQueue.main.async {
                completion(CoreDataManager.shared)
            }
        }
        task.resume()
    }
    
    static var Symbol = "EUR"
    
    static func chartLoad(completion: @escaping ([Currency]) -> Void) {
        let calendar = Calendar.current
        var currency = [Currency]()
        for index in -5...0 {
            let dateLoop = Calendar.current.date(byAdding: .month, value: index, to: Date())
            //WARNING: Crap code
            let url = URL(string: "http://data.fixer.io/api/\(calendar.component(.year, from: dateLoop!))-\((calendar.component(.month, from: dateLoop!)) / 10 == 0 ? "0\(calendar.component(.month, from: dateLoop!))":"\((calendar.component(.month, from: dateLoop!)))")-\(calendar.component(.day, from: dateLoop!) - 1)?access_key=\(API_KEY)&symbols=\(Symbol)")!
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard
                    let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSON
                    else { return }
                let rates = json["rates"] as! NSDictionary
                for currency_ in rates {
                    currency.append(Currency(name: currency_.key as! String, proportion: currency_.value as! Double))
                }
                DispatchQueue.main.async {
                    completion(currency)
                }
            }
            task.resume()
        }
    }
}
