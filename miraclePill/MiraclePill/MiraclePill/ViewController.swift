//
//  ViewController.swift
//  MiraclePill
//
//  Created by Vishal Shah on 10/27/16.
//  Copyright © 2016 Vishal Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var statePickerBtn: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var buyNowBtn: UIButton!
    @IBOutlet weak var successIndicator: UIImageView!
    
    let states = ["Alaska", "Arkansas", "Alabama", "California", "Maine", "New York"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        statePicker.dataSource = self
        statePicker.delegate = self
    }

    @IBAction func stateBtnPressed(_ sender: AnyObject) {
        statePicker.isHidden = false
        countryLabel.isHidden = true
        countryTextField.isHidden = true
        zipLabel.isHidden = true
        zipTextField.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statePickerBtn.setTitle(states[row], for: UIControlState.normal)
        statePicker.isHidden = true
        countryLabel.isHidden = false
        countryTextField.isHidden = false
        zipLabel.isHidden = false
        zipTextField.isHidden = false
    }
    
    @IBAction func buyNowPressed(_ sender: AnyObject) {
        for view in self.view.subviews as [UIView] {
            view.isHidden = true
        }
        
        successIndicator.isHidden = false
    }
    
}

