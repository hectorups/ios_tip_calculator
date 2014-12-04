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
    
    private var tipPercentages = [18, 20, 22]
    
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
        
        var earlier = NSDate().dateByAddingTimeInterval(-5.minutes)
        if (savedValue? != nil && savedValueAt?.compare(earlier).rawValue > 0) {
            billField.text = savedValue!
        }
        
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear")
        
        var currencyPosition = defaults.integerForKey("currency")
        
        if var convertedRank = Currency(rawValue: currencyPosition){
            currency = convertedRank.shortVersion()
        }
        
        var savedPercentate = defaults.integerForKey(percentageDefault)
        
        if defaults.integerForKey("default_low_percentage") != 0 {
            tipPercentages[0] = defaults.integerForKey("default_low_percentage")
        }
        if defaults.integerForKey("default_medium_percentage") != 0 {
            tipPercentages[1] = defaults.integerForKey("default_medium_percentage")
        }
        if defaults.integerForKey("default_high_percentage") != 0 {
            tipPercentages[2] = defaults.integerForKey("default_high_percentage")
        }
        
        tipControl.removeAllSegments()
        for (index, percentage) in enumerate(tipPercentages) {
            tipControl.insertSegmentWithTitle("\(percentage)%", atIndex: index, animated: true)
        }
        tipControl.selectedSegmentIndex = savedPercentate
        
        updateAmounts()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
        defaults.setObject(billField.text, forKey: valueDefault)
        defaults.setObject(NSDate(), forKey: valueDateDefault)
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
        var tip = billAmount * Double(tipPercentage) / 100
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

