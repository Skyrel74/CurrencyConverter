//
//  API.swift
//  Currency Converter
//
//  Created by Ilya on 11.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

enum API {
    
    static var API_KEY: String { return "6923be495780e0cb87df2167ed5de68e" }
    
    static var dataURL: String {
        return "http://data.fixer.io/api/latest?access_key=\(API_KEY)"
    }
    
    static func loadCurrency(completion: @escaping ([Currency]) -> Void) {
        let url = URL(string: dataURL)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! JSON
                else { return }
            let rates = json["rates"] as! NSDictionary
            var currency = [Currency]()
            for currency_ in rates {
                currency.append(Currency(name: currency_.key as! String, proportion: currency_.value as! Double))
            }
            currency.sort { $0.name < $1.name}
            DispatchQueue.main.async {
                completion(currency)
            }
        }
        task.resume()
    }
}
