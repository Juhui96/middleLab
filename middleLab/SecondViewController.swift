//
//  SecondViewController.swift
//  middleLab
//
//  Created by SWUCOMPUTER on 12/04/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

protocol sendBackDelegate {
    func datedataReceived(data: String)
    func calorydataReceived(data: Double)
    
}

class SecondViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate  {

    var delegate : sendBackDelegate?
    
    var dateinfo: String?
    var calinfo:String?
    
    //현재시간
    let timeSelector: Selector = #selector(SecondViewController.updateTime)
    var interval = 2.0
    @IBOutlet var onePerson: UILabel!
    
    var dayArray: [String] = [String]()//날짜변경
    
    //메뉴
    var foodArray: [String] = ["닭볶음탕", "마카롱", "탕수육"]
    var drinkArray: [String] = ["검은콩 두유"," 타로버블티"]
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateSubView: UIView!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var datePicker: UIPickerView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var caloryLabel: UILabel!
    @IBOutlet var caloryTF: UITextField!
    @IBOutlet var menuPicker: UIPickerView!
    
    @IBOutlet var tanLabel: UILabel!
    @IBOutlet var tanProgress: UIProgressView!
    @IBOutlet var danLabel: UILabel!
    @IBOutlet var danProgress: UIProgressView!
    @IBOutlet var jiLabel: UILabel!
    @IBOutlet var jiProgress: UIProgressView!
    
    //현재시간 메소드
    @objc func updateTime(){
        let date = NSDate()
        let fomatter = DateFormatter()
        fomatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        timeLabel.text = "현재시간: " + fomatter.string(from: date as Date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 01...30 {
            dayArray.append(String(i))
        }
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
        dateSubView.isHidden = true
        
        if let date = dateinfo {
            dateLabel.text = date
        }
        onePerson.isHidden = true
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        if pickerView == datePicker{
            return dayArray[row]
        }
        else {
            if component == 0 {
                return foodArray[row]
            }
            else{
                return drinkArray[row]
            }
        }
    }
    func numberOfComponents (in pickerView: UIPickerView) -> Int {
        if pickerView == datePicker{
            return 1
        }
        else {
            return 2
        }
    }
    func pickerView (_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == datePicker{
            return dayArray.count
        }
        else {
            if component == 0 {
                return foodArray.count
            }
            else{
                return drinkArray.count
            }
        }
    }
    @IBAction func savePressed(_ sender: Any) {
        delegate?.datedataReceived(data: dateLabel.text!)
        dismiss(animated: true, completion: nil)
        
        
        if let cal = Double(calinfo!){
            if let kcal = Double(caloryLabel.text!)
            {
                let kkcal = cal + kcal
                delegate?.calorydataReceived(data: kkcal)
                dismiss(animated: true, completion: nil)
                
            }
        }
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func dateChange(_ sender: UIButton) {
        if sender.isTouchInside{
            dateSubView.isHidden = false
        }
    }
    @IBAction func getDate() {
        let day: String = dayArray[self.datePicker.selectedRow(inComponent: 0)]
        dateLabel.text = "April " + day + ", " + "2019"
        dateSubView.isHidden = true
        
    }
    
    @IBAction func okaySelected(_ sender: UIButton) {
         if menuPicker.selectedRow(inComponent: 0) == 0 { //닭볶음탕
            onePerson.isHidden = false
            onePerson.text = "1인분(300g)"
        }
        else if menuPicker.selectedRow(inComponent: 0) == 1{ //마카롱 - 100당 371kcal
            onePerson.isHidden = false
            onePerson.text = "1인분(100g)"
        }
         else if menuPicker.selectedRow(inComponent: 0) == 2{ //탕수육
            onePerson.isHidden = false
            onePerson.text = "1인분(300g)"
        }
        else if menuPicker.selectedRow(inComponent: 1) == 0 { //검은콩 두유
            onePerson.isHidden = false
            onePerson.text = "1팩(190ml)"
        }
        else if menuPicker.selectedRow(inComponent: 0) == 1{ //타로 밀크티
            onePerson.isHidden = false
            onePerson.text = "1컵(270ml)"
        }
        
    }
    
    @IBAction func gSelected(_ sender: UIButton) {
        if let kcal = Double(caloryTF.text!){
        
            if menuPicker.selectedRow(inComponent: 0) == 0 { //닭볶음탕
                caloryLabel.text = String(kcal*1.23)
                tanLabel.text = String(kcal*0.075) + " g"
                tanProgress.progress = 0.3
                danLabel.text = String(kcal*0.123) + " g"
                danProgress.progress = 0.51
                jiLabel.text = String(kcal*0.046) + " g"
                jiProgress.progress = 0.18
            }
            else if menuPicker.selectedRow(inComponent: 0) == 1{ //마카롱 - 100당 371kcal
                caloryLabel.text = String(kcal*3.71)
                tanLabel.text = String(kcal*0.329) + " g"
                tanProgress.progress = 0.5
                danLabel.text = String(kcal*0.043) + " g"
                danProgress.progress = 0.06
                jiLabel.text = String(kcal*0.257) + " g"
                jiProgress.progress = 0.4
            }
            else if menuPicker.selectedRow(inComponent: 0) == 2{ //탕수육 - 300g당 591kcal
                caloryLabel.text = String(kcal*1.97)
                tanLabel.text = String(kcal*0.215) + " g"
                tanProgress.progress = 0.5
                danLabel.text = String(kcal*0.09) + " g"
                danProgress.progress = 0.2
                jiLabel.text = String(kcal*0.079) + " g"
                jiProgress.progress = 0.2
            }
        }
    }
    @IBAction func mlSelected(_ sender: UIButton) {
        if let kcal = Double(caloryTF.text!){
            
            if menuPicker.selectedRow(inComponent: 1) == 0 { //검은콩 두유
                caloryLabel.text = String(kcal*0.525)
                tanLabel.text = String(kcal*0.0375) + " ml"
                tanProgress.progress = 0.3
                danLabel.text = String(kcal*0.0615) + " ml"
                danProgress.progress = 0.6
                jiLabel.text = String(kcal*0.023) + " ml"
                jiProgress.progress = 0.02
            }
            else if menuPicker.selectedRow(inComponent: 0) == 1{ //타로 밀크티
                caloryLabel.text = String(kcal*0.83)
                tanLabel.text = String(kcal*0.15) + " ml"
                tanProgress.progress = 0.86
                danLabel.text = String(kcal*0.003) + " ml"
                danProgress.progress = 0.017
                jiLabel.text = String(kcal*0.02) + " ml"
                jiProgress.progress = 0.11
            }
        }
    }
}
