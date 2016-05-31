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
            self.view.backgroundColor = UIColor.clearColor()
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
            self.view.sendSubviewToBack(blurEffectView)
        }
        else {
            self.view.backgroundColor = UIColor.darkGrayColor()
        }
    }
}
