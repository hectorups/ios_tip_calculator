//
//  ViewController.swift
//  TipCalculator
//
//  Created by Hector Monserrate on 14/08/14.
//  Copyright (c) 2014 Hector Monserrate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tipPercentages = [0.18, 0.2, 0.22]
                            
    @IBOutlet var billField: UITextField
    
    @IBOutlet var tipControl: UISegmentedControl
    
    @IBOutlet var tipLabel: UILabel
    
    @IBOutlet var totalLabel: UILabel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onBillChange(sender: AnyObject) {
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = billField.text.bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        println("in field changed")
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

}

