//
//  ViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 12/12/15.
//  Copyright © 2015 CCE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var leftYellowLight: UIImageView!
    @IBOutlet weak var leftRedLight: UIImageView!
    @IBOutlet weak var leftGreenLight: UIImageView!
    @IBOutlet weak var rightRedLight: UIImageView!
    @IBOutlet weak var rightYellowLight: UIImageView!
    @IBOutlet weak var rightGreenLight: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    var timer = NSTimer()
    var flashLights = NSTimer()
    var counter = 0
    var counting = false
    var time = 0
    
    func updateTimer() {
        time = time - 1
        if (time == Int(Double(counter) * 90 / 100) ) {
            hideGreenLights()
            self.leftYellowLight.hidden = false
            self.rightYellowLight.hidden = false
        } else if (time == 0) {
            flashLights = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "yellowFlashingLights", userInfo: nil, repeats: true)
        } else if (Double(time) == (Double(counter) - (Double(counter)*(1.1)))) {
            flashLights.invalidate()
            timer.invalidate()
            hideYellowLights()
            self.rightRedLight.hidden = false
            self.leftRedLight.hidden = false
            counterLabel.text = "0"
        }
        if (time <= 0) {
            counterLabel.text = "0";
        } else {
            counterLabel.text = "\(time)"
        }
    }
    
    func yellowFlashingLights() {
        if (self.rightYellowLight.hidden) {
            self.rightYellowLight.hidden = false
            self.leftYellowLight.hidden = false
        } else {
            hideYellowLights()
        }
    }
    
    @IBAction func numberButton(sender: UIButton) {
        if (!counting) {
            if (counterLabel.text?.characters.count == 4) {
                counterLabel.text = "0";
            } else {
                if (Int(counterLabel.text!) == 0) {
                    counterLabel.text = "\(sender.currentTitle!)"
                } else {
                    counterLabel.text = "\(counterLabel.text!)\(sender.currentTitle!)"
                }
            }
        }
    }
    
    @IBAction func resetButton(sender: UIButton) {
        if (!counting) {
            if (counterLabel.text == "0") {
                counterLabel.text = String(counter)
            } else if (counterLabel.text == String(counter) || counterLabel.text?.isEmpty == false) {
                time = 0
                counter = 0
                counterLabel.text = "0"
                resetLights()
            }
            timer.invalidate()
            flashLights.invalidate()
        }
    }
    
    func hideRedLights() {
        self.leftRedLight.hidden = true
        self.rightRedLight.hidden = true
    }
    
    func hideYellowLights() {
        self.rightYellowLight.hidden = true
        self.leftYellowLight.hidden = true
    }
    
    func hideGreenLights() {
        self.leftGreenLight.hidden = true
        self.rightGreenLight.hidden = true
    }
    
    func resetLights() {
        hideGreenLights()
        hideRedLights()
        hideYellowLights()
    }
    
    @IBAction func startStopButton(sender: UIButton) {
        if (Int(counterLabel.text!) > 0 && !counting) {
            counter = Int(counterLabel.text!)!
            time = counter
            self.leftGreenLight.hidden = false
            self.rightGreenLight.hidden = false
            timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
            counting = true
        } else {
            counterLabel.text = "0"
            resetLights()
            flashLights.invalidate()
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

