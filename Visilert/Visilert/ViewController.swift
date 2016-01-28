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
    var counter = 0.0
    var counting = false
    var time = 0.0
    var inMode1 = true
    var mode2set = false
    var m2 = Mode2()
    var m1 = Mode1()
    @IBOutlet weak var mode2: UILabel!
    @IBOutlet weak var mode1: UILabel!
    
    @IBOutlet weak var secondsAndMinutes: UISegmentedControl!
    var enableInputClicksWhenVisible: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.stringForKey("mode") == nil) {
            defaults.setObject("1", forKey: "mode")
        } else {
            if (defaults.stringForKey("mode") == "1") {
                inMode1 = true
                mode2.hidden = true
            } else {
                inMode1 = false
                mode2.hidden = false
            }
        }
    }
    
    func updateTimer() {
        time = time - 1
        if (time == (m2.isMode2 ? m2.time1 : m1.time1)) {
            hideGreenLights(true)
            hideYellowLights(false)
        } else if (time == (m2.isMode2 ? m2.time2 : m1.time2)) {
            flashLights = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "yellowFlashingLights", userInfo: nil, repeats: true)
        } else if (time <= (m2.isMode2 ? m2.time3 : m1.time3)) {
            flashLights.invalidate()
            timer.invalidate()
            hideYellowLights(true)
            hideRedLights(false)
            //            m1.isMode1 ? counterLabel.text = "0" : counterLabel.text =
        }
        if (time <= 0) {
            counterLabel.text = "0";
        } else {
            counterLabel.text = "\(Int(time))"
        }
    }
    
    func yellowFlashingLights() {
        rightYellowLight.hidden ? hideYellowLights(false) : hideYellowLights(true)
    }
    
    @IBAction func numberButton(sender: UIButton) {
        if (!counting) {
            
            if (counterLabel.text?.stringByReplacingOccurrencesOfString(" ", withString: "").characters.count == 4) {
                counterLabel.text = "0";
            } else {
                if (Int(counterLabel.text!) == 0) {
                    counterLabel.text = "\(sender.currentTitle!)"
                } else {
                    var number = ""
                    if (sender.currentTitle! == "1") {
                        number = " 1"
                    } else {
                        number = sender.currentTitle!
                    }
                        //                    let attributedString = NSMutableAttributedString(string: "\(counterLabel.text!)\(sender.currentTitle!)")
                        //                    attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, 1))
                        //                    counterLabel.attributedText = attributedString
                    
                    counterLabel.text = "\(counterLabel.text!)\(number)"
                }
            }
        }
    }
    
    @IBAction func resetButton(sender: UIButton) {
        if (!counting) {
            if (counterLabel.text == "0") {
                counterLabel.text = String(Int(counter))
            } else if (counterLabel.text == String(Int(counter)) || counterLabel.text?.isEmpty == false) {
                time = 0
                counter = 0
                counterLabel.text = "0"
                resetLights()
            }
            timer.invalidate()
            flashLights.invalidate()
        }
    }
    
    func hideRedLights(hide: Bool) {
        if (hide) {
            leftRedLight.hidden = true
            rightRedLight.hidden = true
        } else {
            leftRedLight.hidden = false
            rightRedLight.hidden = false
        }
    }
    
    func hideYellowLights(hide: Bool) {
        if (hide) {
            rightYellowLight.hidden = true
            leftYellowLight.hidden = true
        } else {
            rightYellowLight.hidden = false
            leftYellowLight.hidden = false
        }
    }
    
    func hideGreenLights(hide: Bool) {
        if (hide) {
            leftGreenLight.hidden = true
            rightGreenLight.hidden = true
        } else {
            leftGreenLight.hidden = false
            rightGreenLight.hidden = false
        }
    }
    
    func resetLights() {
        hideGreenLights(true)
        hideRedLights(true)
        hideYellowLights(true)
    }
    
    @IBAction func startStopButton(sender: UIButton) {
        if (Int(counterLabel.text!) > 0 && !counting) {
            counter = Double(counterLabel.text!)!
            if (!mode1.hidden) {
                m1.time1 = counter * 90 / 100
                m1.time2 = 0.0
                m1.time3 = counter - (counter * 1.1)
                m1.isMode1 = true
            }
            time = counter
            hideGreenLights(false)
            if (secondsAndMinutes.selectedSegmentIndex == 0){
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
            } else {
                timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
            }
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
        if (!counting) {
            if (inMode1) {
                inMode1 = false
                mode2.hidden = false
            } else {
                inMode1 = true
                mode2.hidden = true
            }
        }
    }
    
    
    @IBAction func programButton(sender: UIButton) {
        if (!inMode1 && rightGreenLight.hidden == true && rightYellowLight.hidden == true && !mode2set) {
            hideGreenLights(false)
        } else if (!inMode1 && rightGreenLight.hidden == false && !mode2set) {
            m2.time1 = Double(counterLabel.text!)!
            hideGreenLights(true)
            hideYellowLights(false)
        } else if (!inMode1 && rightYellowLight.hidden == false && !mode2set) {
            m2.time2 = Double(counterLabel.text!)!
            flashLights = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "yellowFlashingLights", userInfo: nil, repeats: true)
            mode2set = true
        } else if (mode2set) {
            m2.time3 = Double(counterLabel.text!)!
            flashLights.invalidate()
            hideYellowLights(true)
            mode2set = false
            m2.isMode2 = true
        }
    }
}

