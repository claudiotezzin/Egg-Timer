//
//  ViewController.swift
//  Egg Timer
//
//  Created by Claudio Tezzin Jeremias on 03/09/17.
//  Copyright © 2017 Claudio Tezzin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerValue: UILabel!
    
    let initialValue = 210
    var time = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time = initialValue
        timerValue.text = String(time)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func play(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.processTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func reset(_ sender: Any) {
        pause(self)
        time = initialValue
        timerValue.text = String(initialValue)
    }
    
    @IBAction func plusTen(_ sender: Any) {
        time += 10
        timerValue.text = String(time)
    }
    
    @IBAction func minusTen(_ sender: Any) {
        if time > 10 {
            time -= 10
            timerValue.text = String(time)
        }
    }
    
    @objc func processTimer() {
        if time == 0 {
            pause(self)
        } else {
            time -= 1
            timerValue.text = String(time)
        }
    }
    
}

