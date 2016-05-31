//
//  RoundingCardsViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 4/7/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class RoundingCardsViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var evaluatorTextField: UITextField!

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userTextField.resignFirstResponder()
        evaluatorTextField.resignFirstResponder()
    }
}
