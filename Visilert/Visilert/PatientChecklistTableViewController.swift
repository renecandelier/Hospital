//
//  PatientChecklistTableViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 1/27/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class PatientChecklistTableViewController: UITableViewController {

    let checkList = ["Knock prior entering", "Manage up your/co-worker's skill", "User good eye contact"]
    let explain = ["Explain Purpose of rounding", "Explain rounding schedule"]
    let whiteBoard = ["Place name on white board"]
    let headers = ["Introductions", "Explaining Rouding", "Update White Boards", "4P's", "Perform Schedule Task", "Closing"]
    let p = ["Are you comfortable?", "Are you personal items within reach?", "How is your pain?", "Do you need to use the bathroom?"]
    let tasks = ["Complete MD ordered treatments", "Complete nursing care as needed", "Administer nursing care as needed"]
    let closing = ["We will round again in about an hour", "Is there anything else I can do for you?", "Document your rounding on log"]
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return headers.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return checkList.count
        } else if section == 1 {
            return explain.count
        } else if section == 2 {
            return whiteBoard.count
        } else if section == 3 {
            return p.count
        } else if section == 4 {
            return tasks.count
        } else if section == 5 {
            return closing.count
        }
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ChecklistTableViewCell
        if indexPath.section == 0 {
            cell.taskLabel.text = checkList[indexPath.row]
        } else if indexPath.section == 1 {
            cell.taskLabel.text = explain[indexPath.row]
        } else if indexPath.section == 2 {
            cell.taskLabel.text = whiteBoard[indexPath.row]
        } else if indexPath.section == 3 {
            cell.taskLabel.text = p[indexPath.row]
        } else if indexPath.section == 4 {
            cell.taskLabel.text = tasks[indexPath.row]
        } else if indexPath.section == 5 {
            cell.taskLabel.text = closing[indexPath.row]
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func segmentValue() {
        
    }

    

}
