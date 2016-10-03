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
    
    @IBAction func presentHowItWorks(sender: UIButton) {
        titleForNextView = "How It Works"
        pdf = "How It Works"
        performSegueWithIdentifier("PDF", sender: self)
    }
    
    @IBAction func presentOperatingInstructions(sender: UIButton) {
        titleForNextView = "Operating Instructions"
        pdf = "Operating Instructions"
        performSegueWithIdentifier("PDF", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PDF" {
            let upcoming = segue.destinationViewController as! PDFViewController
                upcoming.title = titleForNextView
                upcoming.pdfFile = pdf
        }
    }
}
