//
//  ViewController.swift
//  TimerApp
//
//  Created by Kamil Caglar on 28/08/2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var stopwatch = StopWatchViewController()
    var pomodoro = PomodoroViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func stopWatchButton(_ sender: UIButton) {
    
        func openStopWatchVC() {
            let stopWatchVC = stopwatch
            present(stopWatchVC, animated: true)
        }
        
    }
    
    
    @IBAction func pomodoroButton(_ sender: UIButton) {
        
        func openPomodoroVC() {
            let pomodoroVC = pomodoro
            present(pomodoroVC, animated: true)
        }
        
    }
    
    
    
}
