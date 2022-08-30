//
//  PomodoroViewController.swift
//  TimerApp
//
//  Created by Kamil Caglar on 28/08/2022.
//

import UIKit
import AVFoundation

class PomodoroViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var player: AVAudioPlayer?
    var myTimer = Timer()
    var mysTimer = Timer()
    var isTimerStarted = false
    var workTime = 3 //1500
    var breakTime = 300
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        
        resetButton.isEnabled = true
        
        if !isTimerStarted {
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor.purple, for: .normal)
            
        }else {
            myTimer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        resetButton.isEnabled = false
        myTimer.invalidate()
        mysTimer.invalidate()
        //time = 1500
        isTimerStarted = false
        //timeLabel.text = "25:00"
        
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in
            //do nothing
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.myTimer.invalidate()
            self.mysTimer.invalidate()
            self.workTime = 1500
            self.timeLabel.text = "25:00"
            self.startButton.setTitle("Start", for: .normal)
            self.startButton.setTitleColor(UIColor.blue, for: .normal)
            self.resetButton.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert,animated: true, completion: nil)
        
    }
    
    func startTimer(){
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    func startBreakTime() {
        mysTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(makeBreak)), userInfo: nil, repeats: true)
    }
    
    @objc func makeBreak() {
        breakTime -= 1
        timeLabel.text = formatBreakTime()
    }
    
    @objc func updateTimer(){
        //fix when time < 1
        workTime -= 1
        if workTime == 0{
            playSound()
            myTimer.invalidate()
            startBreakTime()
            timeLabel.text = "05:00"
            startButton.setTitle("Take a break", for: .normal)
        }
        timeLabel.text = formatWorkTime()
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "damn", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func formatBreakTime() -> String{
        let minutes = Int(breakTime) / 60 % 60
        let seconds = Int(breakTime) % 60
        return String(format: "%02d:%02d", minutes,seconds)
    }
    
    func formatWorkTime()->String{
        let minutes = Int(workTime) / 60 % 60
        let seconds = Int(workTime) % 60
        return String(format:"%02d:%02d", minutes, seconds)
        
    }
}
