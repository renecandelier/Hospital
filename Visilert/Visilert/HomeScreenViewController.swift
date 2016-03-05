//
//  HomeScreenViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 12/17/15.
//  Copyright © 2015 CCE. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    var titleForNextView = ""
    var pdf = ""
    
    @IBAction func showOperatingInstructions(sender: AnyObject) {
        titleForNextView = "Operating Instructions"
        pdf = "Visilert Operating Instructions for 3.0 December 11 2015"
        performSegueWithIdentifier("PDF", sender: self)
    }
    
    
    @IBAction func showRoundingCards(sender: AnyObject) {
        titleForNextView = "Rounding Card"
        pdf = "Visilert Rounding Employer Checklist"
        performSegueWithIdentifier("PDF", sender: self)
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PDF" {
            let upcoming = segue.destinationViewController as! PDFViewController
            upcoming.title = titleForNextView
            upcoming.pdfFile = pdf
        }
    }

}
