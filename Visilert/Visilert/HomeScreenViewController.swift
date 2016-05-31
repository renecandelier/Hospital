//
//  HomeScreenViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 12/17/15.
//  Copyright © 2015 CCE. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    // MARK: - Properties
    var titleForNextView = ""
    var pdf = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBarHidden = false
    }
    
    @IBAction func showHowItWorks(sender: AnyObject) {
        titleForNextView = "How It Works"
        pdf = "How It Works"
        performSegueWithIdentifier("PDF", sender: self)
    }
    
    @IBAction func showOperatingInstructions(sender: AnyObject) {
        titleForNextView = "Operating Instructions"
        pdf = "Visilert Operating Instructions for 3.0 December 11 2015"
        performSegueWithIdentifier("PDF", sender: self)
    }

}
