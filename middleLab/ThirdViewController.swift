//
//  ThirdViewController.swift
//  middleLab
//
//  Created by SWUCOMPUTER on 12/04/2019.
//  Copyright © 2019 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, sendBackDelegate {

    var ageGroup: String?
    var name: String?
    
    @IBOutlet var personalLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var caloryLabel: UILabel!
    
    @IBOutlet var tanProgress: UIProgressView!
    @IBOutlet var tanLabel: UILabel!
    @IBOutlet var danProgress: UIProgressView!
    @IBOutlet var danLabel: UILabel!
    @IBOutlet var jiProgress: UIProgressView!
    @IBOutlet var jiLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caloryLabel.text = "0.0"
        
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateLabel.text = dateFormatter.string(from: date as Date)
        if let nameinfo = name{
            personalLabel.text = nameinfo + "님의 하루권장칼로리: 2000칼로리"
        }
        
        tanProgress.progress = 0.0
        tanLabel.text = "0g"
        danProgress.progress = 0.0
        danLabel.text = "0g"
        jiProgress.progress = 0.0
        jiLabel.text = "0g"
       
    }
    @IBAction func dateButtonPressed(_ sender: UIButton) {
        if let buttonText = sender.titleLabel?.text{
            var day: String = "일"
            
            switch buttonText{
            case "1","8","15","22","29" :
                day = "월"
            case "2","9","16","23","30" :
                day = "화"
            case "3","10","17","24" :
                day = "수"
            case "4","11","18","25" :
                day = "목"
            case "5","12","19","26" :
                day = "금"
            case "6","13","20","27" :
                day = "토"
            case "7","14","21","28" :
                day = "일"
            default:
                day = "null"
            }
            dateLabel.text = "April " + buttonText + ", 2019 " + day
            }
        }
    
    @IBAction func sendText(_ sender: UIButton) {
        performSegue(withIdentifier: "viewRegister", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewRegister" {
            let destVC = segue.destination as! SecondViewController
            let date: String! = dateLabel.text
            destVC.dateinfo = date
            
            let cal: String! = caloryLabel.text
            destVC.calinfo = cal
            destVC.delegate = self
        }
    }
    
    func datedataReceived(data: String) {
        dateLabel.text = data
    }
    func calorydataReceived(data: Double) {
        caloryLabel.text = String(data)
    }
    func tandataReceived(data: Double) {
        tanLabel.text = String(data)
    }
}
