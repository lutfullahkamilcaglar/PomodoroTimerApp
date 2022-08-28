//
//  PomodoroViewController.swift
//  TimerApp
//
//  Created by Kamil Caglar on 28/08/2022.
//

import UIKit

class PomodoroViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    
    var myTimer = Timer()
    var isTimerStarted = false
    var time = 1500
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        resetButton.isEnabled = true
        resetButton.alpha = 1.0
        if !isTimerStarted{
            
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor.orange, for: .normal)
            
            
        }else {
            myTimer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
        }
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        resetButton.isEnabled = false
        resetButton.alpha = 0.5
        myTimer.invalidate()
        time = 1500
        isTimerStarted = false
        timeLabel.text = "25:00"
        
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor.blue, for: .normal)
    }
    
    func startTimer(){
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        //fix when time < 1
        time -= 1
        timeLabel.text = formatTime()
    }
    
    func formatTime()->String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02d:%02d", minutes, seconds)
        
    }
}
