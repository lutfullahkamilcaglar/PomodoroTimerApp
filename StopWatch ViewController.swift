//
//  ViewController.swift
//  TimerApp
//
//  Created by Kamil Caglar on 28/08/2022.
//

import UIKit
import Foundation
class StopWatchViewController: UIViewController {
    
    var OurTimer = Timer()
    var TimerDisplayed = 0
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    @IBAction func startButton(_ sender: Any) {
        OurTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopButton(_ sender: Any) {
        OurTimer.invalidate()
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
//      OurTimer.invalidate()
        //TimerDisplayed = 0
        //timeLabel.text = "00:00:00"
        
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //do nothing
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.TimerDisplayed = 0
            self.OurTimer.invalidate()
            self.timeLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
//            self.startButton.setTitle("START", for: .normal)
//            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert,animated: true, completion: nil)
        
    }
    
    @objc func Action() {
        TimerDisplayed += 1
        timeLabel.text = String(TimerDisplayed)
        
        let time = secondsToHoursMinutesSeconds(seconds: TimerDisplayed)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timeLabel.text = timeString
        
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

