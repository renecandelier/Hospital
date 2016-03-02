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

    @IBOutlet weak var deviceImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func slider(sender: AnyObject) {
        if (UIImage(named: "a_0\(deviceSlider.value)") != nil) {
            deviceImageView.image = UIImage(named: "a_0\(deviceSlider.value)")
        }
    }
}
