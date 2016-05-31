//
//  RoundingCardsTableViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 5/6/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class RoundingCardsTableViewController: UITableViewController {
   
    // MARK: - Properties
    var pdf = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rounding Cards"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0  :
            pdf = "Visilert Rounding Employer Checklist"
        case 1  :
            pdf = "Visilert Hourly Rounding Card"
        case 2  :
            pdf = "Visilert Patient Card"
        case 3  :
            pdf = "Visilert Rounding Checklist"
        default :
            pdf = "Visilert Rounding Checklist"
        }
            performSegueWithIdentifier("PDF", sender: self)
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PDF" {
            let upcoming = segue.destinationViewController as! PDFViewController
            upcoming.title = pdf
            upcoming.pdfFile = pdf
        }
    }


}
