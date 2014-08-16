//
//  ViewController.swift
//  TipCalculator
//
//  Created by Hector Monserrate on 14/08/14.
//  Copyright (c) 2014 Hector Monserrate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let valueDefault = "value"
    let valueDateDefault = "value_date"
    let percentageDefault = "percentage"
    
    private let tipPercentages = [0.18, 0.2, 0.22]
    
    private var currency = "$"
    
    private var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var resultsView: UIView!
                            
    @IBOutlet var billField: UITextField!
    
    @IBOutlet var tipControl: UISegmentedControl!
    
    @IBOutlet var tipLabel: UILabel!
    
    @IBOutlet var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var savedValue : String? = defaults.objectForKey(valueDefault) as? String
        var savedValueAt : NSDate? = defaults.objectForKey(valueDateDefault) as? NSDate
        var savedPercentate = defaults.integerForKey(percentageDefault)
        
        var earlier = NSDate.date().dateByAddingTimeInterval(-5.minutes)
        if (savedValue? != nil && savedValueAt?.compare(earlier).toRaw() > 0) {
            billField.text = savedValue!
        }
        
        tipControl.selectedSegmentIndex = savedPercentate
        
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
        
        defaults.setObject(billField.text, forKey: valueDefault)
        defaults.setObject(NSDate.date(), forKey: valueDateDefault)
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: percentageDefault)
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
        
        if (billAmount > 0) {
            showResults(1.0, duration: 2.0)
        } else {
            showResults(0.0, duration: 0.0)
        }
        
        
        updateLabel(tipLabel, value: tip)
        updateLabel(totalLabel, value: total)
    }
    
    private func updateLabel(label: UILabel, value: Double){
        var nf = NSNumberFormatter()
        nf.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        nf.currencySymbol = currency
        
        label.text = nf.stringFromNumber(value)
    }
    
    private func showResults(alpha: CGFloat, duration: Double) {
        UIView.animateWithDuration(duration, animations: {
            for subView : AnyObject in self.resultsView.subviews {
                var sv : UIView = subView as UIView
                sv.alpha = alpha
            }
        })
        
        UIView.animateWithDuration(2.0, animations: {
            var scale : CGFloat = alpha == 1 ? 1.0 : 1.75
            self.billField.transform = CGAffineTransformMakeScale(scale, scale)
        })
        
        
    }
}

