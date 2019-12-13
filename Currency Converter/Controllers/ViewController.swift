//
//  ViewController.swift
//  Currency Converter
//
//  Created by Ilya on 11.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var converterContainer: UIView!
    @IBOutlet weak var favoriteContainer: UIView!
    
    //Switch action for navigation
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
    }

}
