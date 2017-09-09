//
//  FormViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 1/16/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            self.view.backgroundColor = UIColor.clear
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            self.view.sendSubview(toBack: blurEffectView)
        }
        else {
            self.view.backgroundColor = UIColor.darkGray
        }
    }
}
