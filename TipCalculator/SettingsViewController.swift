//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Hector Monserrate on 14/08/14.
//  Copyright (c) 2014 Hector Monserrate. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var tipPercentages = [18, 20, 22]
    
    private var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var lowTip: UILabel!
    
    @IBOutlet weak var mediumTip: UILabel!
    
    @IBOutlet weak var highTip: UILabel!
    
    @IBOutlet var currencyPicker: UIPickerView!
    
    @IBOutlet weak var lowTipStepper: UIStepper!
    
    @IBOutlet weak var mediumTipStepper: UIStepper!
    
    @IBOutlet weak var highTipStepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        var currencyPosition = defaults.integerForKey("currency")
        
        currencyPicker.selectRow(currencyPosition, inComponent: 0,animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        if defaults.integerForKey("default_low_percentage") != 0 {
            tipPercentages[0] = defaults.integerForKey("default_low_percentage")
        }
        if defaults.integerForKey("default_medium_percentage") != 0 {
            tipPercentages[1] = defaults.integerForKey("default_medium_percentage")
        }
        if defaults.integerForKey("default_high_percentage") != 0 {
            tipPercentages[2] = defaults.integerForKey("default_high_percentage")
        }
        
        lowTip.text = "\(tipPercentages[0])%"
        lowTipStepper.value = Double(tipPercentages[0])
        mediumTip.text = "\(tipPercentages[1])%"
        mediumTipStepper.value = Double(tipPercentages[1])
        highTip.text = "\(tipPercentages[2])%"
        highTipStepper.value = Double(tipPercentages[2])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onDone(sender: AnyObject) {
        var currency = currencyPicker.selectedRowInComponent(0)
        defaults.setInteger(currency, forKey: "currency")
        defaults.setInteger(tipPercentages[0], forKey: "default_low_percentage")
        defaults.setInteger(tipPercentages[1], forKey: "default_medium_percentage")
        defaults.setInteger(tipPercentages[2], forKey: "default_high_percentage")
        defaults.synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func percentageUp(sender: UIStepper) {
        var i = 2
        var label = highTip;
        switch sender {
            case lowTipStepper:
                i = 0
                label = lowTip
            case mediumTipStepper:
                i = 1
                label = mediumTip
            default:
                i = 2
                label = highTip
        }
        
        tipPercentages[i] = Int(sender.value)
        label.text = "\(tipPercentages[i])%"
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
