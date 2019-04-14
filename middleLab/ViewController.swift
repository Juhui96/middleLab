//
//  ViewController.swift
//  middleLab
//
//  Created by SWUCOMPUTER on 12/04/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet var enjoySubView: UIView!
    @IBOutlet var nameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enjoySubView.isHidden = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThirdView" {
            let destination = segue.destination as! ThirdViewController
            destination.name = nameTF.text
        }
    }
    
    @IBAction func enjoyPressed(_ sender: UIButton) {
        if sender.isTouchInside{
            enjoySubView.isHidden = false
        }
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        if sender.isTouchInside{
            enjoySubView.isHidden = true
        }
    }
}

