//
//  Currency.swift
//  Currency Converter
//
//  Created by Ilya on 11.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

class Currency {
    
    static var shared = [Currency]()
    
    var name: String
    var proportion: Double
    
    // MARK: - Initialization
    
    init(name: String, proportion: Double) {
        self.name = name
        self.proportion = proportion
    }
}
