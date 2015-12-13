//
//  ViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 12/12/15.
//  Copyright © 2015 CCE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    var timer = NSTimer()
    var counter = 0
    var counting = false
    var resetToInitialValue = true
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateTimer() {
        let newTime = Int(counterLabel.text!)! - 1
        if (Int(counterLabel.text!)! == Int(Double(counter) * 90 / 100) + 1) {
            counterLabel.textColor = UIColor.yellowColor()
        } else if (Int(counterLabel.text!)! == 1) {
            counterLabel.textColor = UIColor.darkGrayColor()
        } else if(Int(counterLabel.text!)! == Int(Double(counter) * (-10/100)) + 1) {
            counterLabel.textColor = UIColor.redColor()
        }
        counterLabel.text = "\(newTime)"
    }

    @IBAction func numberButton(sender: UIButton) {
        if (counterLabel.text?.characters.count == 3) {
            counterLabel.text = "0";
        } else {
            if (Int(counterLabel.text!) == 0) {
                counterLabel.text = "\(sender.currentTitle!)"
            } else {
                counterLabel.text = "\(counterLabel.text!)\(sender.currentTitle!)"
            }
        }
    }

    @IBAction func resetButton(sender: UIButton) {
        if (counting == false && counterLabel.text == "0") {
            counterLabel.text = String(counter)
        } else if (counterLabel.text == String(counter) || counterLabel.text?.isEmpty == false) {
            timer.invalidate()
            counting = false
            counter = 0
            counterLabel.text = "0"
        }
    }
    
    @IBAction func startStopButton(sender: UIButton) {
        if (Int(counterLabel.text!) > 0 && !counting) {
            counter = Int(counterLabel.text!)!
            timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
            counting = true
        } else {
            counterLabel.text = "0"
            counting = false
            timer.invalidate()
        }
    }
    
    @IBAction func modeButton(sender: UIButton) {
        print("mode buttons")
    }
    
    @IBAction func programButton(sender: UIButton) {
        print("program button")
    }
}

