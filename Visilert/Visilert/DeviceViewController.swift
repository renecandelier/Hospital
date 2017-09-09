//
//  ViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 12/12/15.
//  Copyright © 2015 CCE. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class DeviceViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var leftYellowLight: UIImageView!
    @IBOutlet weak var leftRedLight: UIImageView!
    @IBOutlet weak var leftGreenLight: UIImageView!
    @IBOutlet weak var rightRedLight: UIImageView!
    @IBOutlet weak var rightYellowLight: UIImageView!
    @IBOutlet weak var rightGreenLight: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var mode2: UILabel!
    @IBOutlet weak var mode1: UILabel!
    @IBOutlet weak var secondsAndMinutes: UISegmentedControl!
    @IBOutlet weak var trianingStackView: UIStackView!
    @IBOutlet weak var trainingNumber: UILabel!
    @IBOutlet weak var trainingLabel: UILabel!
    @IBOutlet weak var trainingMode1: UIButton!
    @IBOutlet weak var trainingMode2: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Properties
    var timer = Timer()
    var flashLights = Timer()
    var counter = 0.0
    var counting = false
    var time = 0.0
    var inMode1 = true
    var mode2set = false
    var m2 = Mode2()
    var m1 = Mode1()
    var inTrainingMode1 = false
    var inTrainingMode2 = false
    let mode2Training = ["Press the “Mode” button.", "Press the program “Prog” button" , "Enter 120", "Press Prog", "Enter 30", "Press Prog", "Enter 30", "Press the program “Prog” button","Select the Start/Stop Button","Press the Start/Stop Button when seeing the Patient", "Press the Reset to Start Timer from 180"]
    let mode1Training = ["Enter 60", "Select the Start/Stop Button", "Press Start/Stop when seeing patient", "Press Reset to start timer from 60"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: "mode") == nil) {
            defaults.set("1", forKey: "mode")
        } else {
            if (defaults.string(forKey: "mode") == "1") {
                inMode1 = true
                mode2.isHidden = true
            } else {
                inMode1 = false
                mode2.isHidden = false
            }
        }
    }
    
    @IBAction func closeView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateTimer() {
        time = time - 1
        if (time == (m2.isMode2 ? m2.time1 : m1.time1)) {
            hideGreenLights(true)
            hideYellowLights(false)
        } else if (time == (m2.isMode2 ? m2.time2 : m1.time2)) {
            flashLights = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(yellowFlashingLights), userInfo: nil, repeats: true)
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
        rightYellowLight.isHidden ? hideYellowLights(false) : hideYellowLights(true)
    }
    
    @IBAction func numberButton(_ sender: UIButton) {
        if (!counting) {
            if (counterLabel.text?.replacingOccurrences(of: " ", with: "").characters.count == 4) {
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
                    counterLabel.text = "\(counterLabel.text!)\(number)"
                }
            }
        }
        if inTrainingMode2 {
            if counterLabel.text == "120" {
                nextTrainingMode2Step(3)
            }
            if counterLabel.text == "30" && !flashLights.isValid {
                nextTrainingMode2Step(5)
            }
            if counterLabel.text == "30" && flashLights.isValid {
                nextTrainingMode2Step(7)
            }
        }
        if inTrainingMode1 && counterLabel.text == "60" {
            nextTrainingMode1Step(1)
        }
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        if inTrainingMode1 && trainingLabel.text == mode1Training[3] {
         nextTrainingMode1Step(1)
        } else if inTrainingMode2 && trainingLabel.text == mode2Training[10] {
            nextTrainingMode2Step(8)
        }
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
    
    func hideRedLights(_ hide: Bool) {
        if (hide) {
            leftRedLight.isHidden = true
            rightRedLight.isHidden = true
        } else {
            leftRedLight.isHidden = false
            rightRedLight.isHidden = false
        }
    }
    
    func hideYellowLights(_ hide: Bool) {
        if (hide) {
            rightYellowLight.isHidden = true
            leftYellowLight.isHidden = true
        } else {
            rightYellowLight.isHidden = false
            leftYellowLight.isHidden = false
        }
    }
    
    func hideGreenLights(_ hide: Bool) {
        if (hide) {
            leftGreenLight.isHidden = true
            rightGreenLight.isHidden = true
        } else {
            leftGreenLight.isHidden = false
            rightGreenLight.isHidden = false
        }
    }
    
    func resetLights() {
        hideGreenLights(true)
        hideRedLights(true)
        hideYellowLights(true)
    }
    
    @IBAction func startStopButton(_ sender: UIButton) {
        if inTrainingMode1 && counterLabel.text == "60" {
            nextTrainingMode1Step(2)
        } else if inTrainingMode1 {
            nextTrainingMode1Step(3)
        }
        if inTrainingMode2 && trainingLabel.text == mode2Training[9] {
            nextTrainingMode2Step(10)
        } else if inTrainingMode2 {
            nextTrainingMode2Step(9)
        }
        if (Int(counterLabel.text!) > 0 && !counting) {
            counter = Double(counterLabel.text!)!
            if (!mode1.isHidden) {
                m1.time1 = counter * 10 / 100
                m1.time2 = 0.0
                m1.time3 = counter - (counter * 1.1)
                m1.isMode1 = true
            }
            time = counter
            hideGreenLights(false)
            if (secondsAndMinutes.selectedSegmentIndex == 0){
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            } else {
                timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
            counting = true
        } else {
            reset()
        }
    }
    
    func reset() {
        counterLabel.text = "0"
        resetLights()
        flashLights.invalidate()
        counting = false
        timer.invalidate()
    }
    
    @IBAction func modeButton(_ sender: UIButton) {
        if inTrainingMode2 == true {
            nextTrainingMode2Step(1)
        }
        if (!counting) {
            if (inMode1) {
                inMode1 = false
                mode2.isHidden = false
            } else {
                inMode1 = true
                mode2.isHidden = true
            }
        }
    }
    
    @IBAction func programButton(_ sender:
        UIButton) {
        if inTrainingMode2 == true {
            if counterLabel.text == "0" {
                nextTrainingMode2Step(2)
            }
            if counterLabel.text == "120" {
                nextTrainingMode2Step(4)
            }
            if counterLabel.text == "30" && rightYellowLight.isHidden == false {
                nextTrainingMode2Step(6)
            }
            if counterLabel.text == "30" && flashLights.isValid {
                nextTrainingMode2Step(8)
            }
            
        }
        if (!inMode1 && rightGreenLight.isHidden == true && rightYellowLight.isHidden == true && !mode2set) {
            hideGreenLights(false)
            counterLabel.text = "0"
        } else if (!inMode1 && rightGreenLight.isHidden == false && !mode2set) {
            m2.time1 = Double(counterLabel.text!)!
            hideGreenLights(true)
            hideYellowLights(false)
            counterLabel.text = "0"
        } else if (!inMode1 && rightYellowLight.isHidden == false && !mode2set) {
            m2.time2 = Double(counterLabel.text!)!
            flashLights = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(yellowFlashingLights), userInfo: nil, repeats: true)
            mode2set = true
            counterLabel.text = "0"
        } else if (mode2set) {
            m2.time3 = Double(counterLabel.text!)!
            flashLights.invalidate()
            hideYellowLights(true)
            mode2set = false
            m2.isMode2 = true
            counterLabel.text = "\(Int(m2.time1 + m2.time2 + m2.time3))"
        }
    }
    
    @IBAction func startTraining(_ sender: AnyObject) {
        if inTrainingMode1 == false {
            trianingStackView.isHidden = false
            inTrainingMode1 = true
            nextTrainingMode1Step(0)
            trainingMode2.isEnabled = false
            trainingMode2.alpha = 0.5
            trainingMode1.setTitle("Stop Mode I", for: UIControlState())
            trainingMode1.backgroundColor = UIColor.red
        } else {
            reset()
            inTrainingMode1 = !inTrainingMode1
            trainingMode1.setTitle("Start Mode I", for: UIControlState())
            trainingMode2.isEnabled = true
            trainingMode2.alpha = 1.0
            trianingStackView.isHidden = true
            trainingMode1.backgroundColor = UIColor(red:0.67, green:0.78, blue:0.17, alpha:1.00)
        }
    }
    
    @IBAction func startTranningMode2(_ sender: AnyObject) {
        if inTrainingMode2 == false {
            trianingStackView.isHidden = false
            inTrainingMode2 = true
            trainingMode1.isEnabled = false
            trainingMode1.alpha = 0.5
            trainingMode2.setTitle("Stop Mode II", for: UIControlState())
            nextTrainingMode2Step(0)
            inMode1 = true
            mode2.isHidden = true
            trainingMode2.backgroundColor = UIColor.red
        } else {
            reset()
            inTrainingMode2 = !inTrainingMode2
            trainingMode1.isEnabled = true
            trainingMode1.alpha = 1.0
            trainingMode2.setTitle("Start Mode II", for: UIControlState())
            trianingStackView.isHidden = true
            trainingMode2.backgroundColor = UIColor(red:0.67, green:0.78, blue:0.17, alpha:1.00)
        }
    }
    
    func nextTrainingMode2Step(_ step: Int) {
        trainingNumber.text = String(step + 1)
        trainingLabel.text = mode2Training[step]
    }
    
    func nextTrainingMode1Step(_ step: Int) {
        trainingNumber.text = String(step + 1)
        trainingLabel.text = mode1Training[step]
    }
    
}

