//
//  PickerVC.swift
//  Currency Converter
//
//  Created by Ilya on 15.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import UIKit

class PickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    var firstCurrency: Int = 0;
    var secondCurrency: Int = 0;

    
    //OBJECTS
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var firstPickerView: UIPickerView!
    @IBOutlet weak var secondPickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func convert(_ sender: UIButton) {
        if(input.text != "") {
            resultLabel.text = "\(input.text!) \(CoreDataManager.shared[firstCurrency].value(forKey: "name") as! String) equal \(Double(input.text!)! * ((CoreDataManager.shared[firstCurrency].value(forKey: "proportion") as! Double)/(CoreDataManager.shared[secondCurrency].value(forKey: "proportion") as! Double))) \(CoreDataManager.shared[secondCurrency].value(forKey: "name") as! String)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.firstPickerView.reloadAllComponents()
        self.secondPickerView.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CoreDataManager.shared.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CoreDataManager.shared[row].value(forKey: "name") as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.accessibilityIdentifier == "first" {
            secondCurrency = row
        }
        else {
            firstCurrency = row
        }
    }
    
}

extension PickerVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharecters = CharacterSet.decimalDigits
        let charecterSet = CharacterSet(charactersIn: string)
        return allowedCharecters.isSuperset(of: charecterSet)
    }
}
