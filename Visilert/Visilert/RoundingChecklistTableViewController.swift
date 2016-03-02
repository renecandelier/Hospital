//
//  RoundingChecklistTableViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 3/1/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class RoundingChecklistTableViewController: UITableViewController {
    let checklist = ["Turn off Visilert device prior to entering patrient's room. Press Start/Strop Button", "Use opening Key Words such as 'round' to introduce yourself, your skill set, your experience and others. This will make the patient comfortable with the term. Show a genuine interest in your patient.", "Complete schedule task needed for that patient such as medications, treatments, procedures, and feelings.", "Asses the patient's pain. Offer PRN medications at the begining of the round and write the next available time of pain medication administration on the white board.", "Assess the patient's position. Straighten sheet, offer something to drink, open or close curtains as desired by patien and adjust lighting/temparature.", "Assess the patrient's personal Items. Is the call light, water, telephone, light switch, TV control, trash can, and bedside table within the patrient's reach?", "Assess the patient's need to use the bathroom(Potty). Offer to take the patient to the bathroom.", "Use close Phrase such as 'Is there anything else I can do for you?' Do not say, 'Call if you need me.'", "Reset Visilert device and document rounding once you ensure is completed. Press Reset (select appropiate rounding time) Press Start/Stop Button"]
    var lastSelection: NSIndexPath!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 44.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    }
    internal var selectedIndexPath:NSIndexPath? = nil

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RoundingListTableViewCell
//        if (selectedIndexPath == true) {
//            cell.accessoryType = .Checkmark
//        } else {
//            cell.accessoryType = .None
//        }
        cell.checkListTextLabel?.text = checklist[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .None
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
    }

}
