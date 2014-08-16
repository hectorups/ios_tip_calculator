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
    
    private var defaults = NSUserDefaults.standardUserDefaults()
                            
    @IBOutlet var billField: UITextField!
    
    @IBOutlet var tipControl: UISegmentedControl!
    
    @IBOutlet var tipLabel: UILabel!
    
    @IBOutlet var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var savedValue : String? = defaults.objectForKey("value") as? String
        var savedValueAt : NSDate? = defaults.objectForKey("value_date") as? NSDate
        
        var earlier = NSDate.date().dateByAddingTimeInterval(-5.minutes)
        if (savedValue? != nil && savedValueAt?.compare(earlier).toRaw() > 0) {
            billField.text = savedValue!
        }
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
        
        var currencyPosition = defaults.integerForKey("currency")
        
        if var convertedRank = Currency.fromRaw(currencyPosition){
            currency = convertedRank.shortVersion()
        }
        
        updateAmounts()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        defaults.setObject(billField.text, forKey: "value")
        defaults.setObject(NSDate.date(), forKey: "value_date")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
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

