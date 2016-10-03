//
//  Device360ViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 3/2/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class Device360ViewController: UIViewController {
    @IBOutlet weak var deviceSlider: UISlider!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet weak var deviceImageView: UIImageView!
    let panRec = UIPanGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        panRec.addTarget(self, action: #selector(Device360ViewController.handlePan(_:)))
        deviceImageView.addGestureRecognizer(panRec)
    }
    func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began || gestureRecognizer.state == UIGestureRecognizerState.Changed {
            let translation = gestureRecognizer.translationInView(self.view)
            // note: 'view' is optional and need to be unwrapped
            
            if (UIImage(named: "b_0\(Int(translation.x)/50)") != nil) {
                deviceImageView.image = UIImage(named: "b_0\(Int((translation.x))/50)")
            }
        }
    }

    @IBAction func slider(sender: AnyObject) {
        if (UIImage(named: "b_0\(deviceSlider.value)") != nil) {
            deviceImageView.image = UIImage(named: "b_0\(deviceSlider.value)")
        }
    }


    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesMoved(touches, withEvent: event)
//        let touchLocation = touch.locationInView(self.view)

        let touch = touches.first! as UITouch
        
        if (touch.view == deviceImageView) {
            print("touchesMoved | This is an ImageView \(touches.reverse().first)")
        }else{
            print("touchesMoved | This is not an ImageView")
        }
    }
}
