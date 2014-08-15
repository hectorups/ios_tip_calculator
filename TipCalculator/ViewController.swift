//
//  ViewController.swift
//  TipCalculator
//
//  Created by Hector Monserrate on 14/08/14.
//  Copyright (c) 2014 Hector Monserrate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let tipPercentages = [0.18, 0.2, 0.22]
    
    private var currency = "$"
                            
    @IBOutlet var billField: UITextField!
    
    @IBOutlet var tipControl: UISegmentedControl!
    
    @IBOutlet var tipLabel: UILabel!
    
    @IBOutlet var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
        
        var defaults = NSUserDefaults.standardUserDefaults()
        var currencyPosition = defaults.integerForKey("currency")
        
        if var convertedRank = Currency.fromRaw(currencyPosition){
            currency = convertedRank.shortVersion()
        }
        
        updateAmounts()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        println("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        println("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        println("view did disappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onBillChange(sender: AnyObject) {
        updateAmounts()
    }
    
    private func updateAmounts(){
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAbountString = NSString(string: billField.text)
        var billAmount = billAbountString.doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        updateLabel(tipLabel, value: tip)
        updateLabel(totalLabel, value: total)
    }
    
    private func updateLabel(label: UILabel, value: Double){
        var nf = NSNumberFormatter()
        nf.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        nf.currencySymbol = currency
        
        label.text = nf.stringFromNumber(value)
    }

}

