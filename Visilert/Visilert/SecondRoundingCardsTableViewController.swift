//
//  SecondRoundingCardsTableViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 4/7/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class SecondRoundingCardsTableViewController: UITableViewController {
    
    let headers = ["4P's", "Perform Schedule Task", "Closing"]
    let p = ["Are you comfortable?", "Are you personal items within reach?", "How is your pain?", "Do you need to use the bathroom?"]
    let tasks = ["Complete MD ordered treatments", "Complete nursing care as needed", "Administer nursing care as needed"]
    let closing = ["We will round again in about an hour", "Is there anything else I can do for you?", "Document your rounding on log"]
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return p.count
        } else if section == 1 {
            return tasks.count
        } else if section == 2 {
            return closing.count
        } else if section == 3 {
            return p.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChecklistTableViewCell
        if indexPath.section == 0 {
            cell.taskLabel.text = p[indexPath.row]
        } else if indexPath.section == 1 {
            cell.taskLabel.text = tasks[indexPath.row]
        } else if indexPath.section == 2 {
            cell.taskLabel.text = closing[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 22))
        let label = UILabel(frame: CGRect(x: 10, y: 2, width: tableView.frame.size.width, height: 22))
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(red:0.67, green:0.78, blue:0.17, alpha:1.0)
        label.text = headers[section]
        view.addSubview(label)
        view.backgroundColor = UIColor.white
        return view
    }

}
