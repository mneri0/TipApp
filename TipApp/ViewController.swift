//
//  ViewController.swift
//  TipApp
//
//  Created by Mike Neri on 12/30/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipAmountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    // Used to be able to turn to dark mode
    @IBOutlet weak var billAmountTitle: UILabel!
    @IBOutlet weak var tipTitle: UILabel!
    @IBOutlet weak var totalTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tip Calulator"
        tipPercentageLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // Set out default values
        let defaults = UserDefaults.standard
        defaults.setValue(15, forKey: "Segment 1")
        defaults.setValue(18, forKey: "Segment 2")
        defaults.setValue(20, forKey: "Segment 3")
        defaults.setValue(false, forKey: "Dark Mode")
        
        // Make sure keyboard pops up instantly as app launches
        [billAmountTextField .becomeFirstResponder()]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        print("view will appear")
        
        let defaults = UserDefaults.standard

        if defaults.bool(forKey: "Dark Mode") == true {
            self.view.backgroundColor = .darkGray
            tipPercentageLabel.textColor = .white
            totalLabel.textColor = .white
            billAmountTitle.textColor = .white
            tipTitle.textColor = .white
            totalTitle.textColor = .white
            tipAmountSegmentedControl.backgroundColor = .systemBackground
        }
        else {
            self.view.backgroundColor = .white
            tipPercentageLabel.textColor = .black
            totalLabel.textColor = .black
            billAmountTitle.textColor = .black
            tipTitle.textColor = .black
            totalTitle.textColor = .black
            tipAmountSegmentedControl.backgroundColor = .systemBackground
        }
        
        billAmountTextField.text = ""
        tipPercentageLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // Retrieve UserDefaults
        let percentOne = defaults.integer(forKey: "Segment 1")
        let percentTwo = defaults.integer(forKey: "Segment 2")
        let percentThree = defaults.integer(forKey: "Segment 3")
        
        // Update percentages on the segemented control item
        tipAmountSegmentedControl.setTitle("\(percentOne)%", forSegmentAt: 0)
        tipAmountSegmentedControl.setTitle("\(percentTwo)%", forSegmentAt: 1)
        tipAmountSegmentedControl.setTitle("\(percentThree)%", forSegmentAt: 2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    @IBAction func onTap(_ sender: Any) {
        print("hello")
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get initial bill amount and calculate tips
        let bill = Double(billAmountTextField.text!) ?? 0
        
        let defaults = UserDefaults.standard
        let percentOne = defaults.integer(forKey: "Segment 1")
        let percentTwo = defaults.integer(forKey: "Segment 2")
        let percentThree = defaults.integer(forKey: "Segment 3")
        
        let tipPercentages = [Double(percentOne) / 100, Double(percentTwo) / 100, Double(percentThree) / 100]
                
        // Calculate tip and total
        let tip = bill * tipPercentages[tipAmountSegmentedControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Update the tip and total labels
        tipPercentageLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)

    }
    
}

