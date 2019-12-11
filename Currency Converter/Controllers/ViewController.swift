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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        API.loadCurrency { currencyArray in
            Currency.shared = currencyArray
        }
    }

}

/*
 extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
 func numberOfComponents(in pickerView: UIPickerView) -> Int
 {
 return 1
 }
 
 func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
 {
 return myCurrency.count
 }
 
 func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
 {
 return myCurrency[row]
 }
 
 func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
 {
 activeCurrency = myValues[row]
 }
 
 //BUTTON
 @IBAction func action(_ sender: AnyObject)
 {
 if (input.text != "")
 {
 output.text = String(Double(input.text!)! * activeCurrency)
 }
 }
 }
 */
