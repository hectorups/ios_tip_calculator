//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Hector Monserrate on 14/08/14.
//  Copyright (c) 2014 Hector Monserrate. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        var currencyPosition = defaults.integerForKey("currency")
        currencyPicker.selectRow(currencyPosition, inComponent: 0,animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onDone(sender: AnyObject) {
        var currency = currencyPicker.selectedRowInComponent(0)
        defaults.setInteger(currency, forKey: "currency")
        defaults.synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return Currency.allValues.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        var currency : String
        currency = "$"
        if var convertedRank = Currency.fromRaw(row){
            currency = convertedRank.longVersion()
        }
        
        return currency
    }
    
}
