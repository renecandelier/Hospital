//
//  PatientChecklistTableViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 1/27/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class PatientChecklistTableViewController: UITableViewController {
    
    let headers = ["Introductions", "Explaining Rounding", "Update White Boards"]
    let checkList = ["Knock prior entering", "Manage up your/co-worker's skill", "User good eye contact"]
    let explain = ["Explain Purpose of rounding", "Explain rounding schedule"]
    let whiteBoard = ["Place name on white board"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return checkList.count
        } else if section == 1 {
            return explain.count
        } else if section == 2 {
            return whiteBoard.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ChecklistTableViewCell
        if indexPath.section == 0 {
            cell.taskLabel.text = checkList[indexPath.row]
        } else if indexPath.section == 1 {
            cell.taskLabel.text = explain[indexPath.row]
        } else if indexPath.section == 2 {
            cell.taskLabel.text = whiteBoard[indexPath.row]
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
