//
//  SettingsViewController.swift
//  TipApp
//
//  Created by Mike Neri on 12/30/20.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var percentOneTextField: UITextField!
    @IBOutlet weak var percentTwoTextField: UITextField!
    @IBOutlet weak var percentThreeTextField: UITextField!

    // Used to be able to turn to dark mode
    @IBOutlet weak var darkModeTitle: UILabel!
    @IBOutlet weak var percentOneTitle: UILabel!
    @IBOutlet weak var percentTwoTitle: UILabel!
    @IBOutlet weak var percentThreeTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Settings"
    }

    func enableDark() {
        self.view.backgroundColor = .darkGray
        darkModeTitle.textColor = .white
        percentOneTitle.textColor = .white
        percentTwoTitle.textColor = .white
        percentThreeTitle.textColor = .white
    }
    
    func disableDark(){
        self.view.backgroundColor = .white
        darkModeTitle.textColor = .black
        percentOneTitle.textColor = .black
        percentTwoTitle.textColor = .black
        percentThreeTitle.textColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        let defaults = UserDefaults.standard
        
        // Make sure we are changing modes
        if defaults.bool(forKey: "Dark Mode") == true{
            darkModeSwitch.setOn(true, animated: true)
            enableDark()
        }
        else {
            disableDark()
        }
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
        super.viewDidAppear(animated)
        print("view did disappear")
    }
    
    @IBAction func onTap(_ sender: Any) {
        print("whats up")
        view.endEditing(true)
    }

    
    @IBAction func changeSettings(_ sender: Any) {
        let defaults = UserDefaults.standard

        // Check initial mode and update
        let darkEnabled = darkModeSwitch.isOn
        defaults.setValue(darkEnabled, forKey: "Dark Mode")
        
        if darkEnabled == true {
            enableDark()
        }
        else {
            disableDark()
        }
        
        // Update percentage tips
        let percentOne = Int(percentOneTextField.text!) ?? 0
        let percentTwo = Int(percentTwoTextField.text!) ?? 0
        let percentThree = Int(percentThreeTextField.text!) ?? 0
        
        // If any change was made make sure we updates our UserDefaults
        if percentOne != 0 {
            defaults.setValue(percentOne, forKey: "Segment 1")
        }
        if percentTwo != 0 {
            defaults.setValue(percentTwo, forKey: "Segment 2")
        }
        if percentThree != 0 {
            defaults.setValue(percentThree, forKey: "Segment 3")
        }
        print(percentOne)
        print(percentTwo)
        print(percentThree)

        defaults.synchronize()
        
    }

}
