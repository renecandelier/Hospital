//
//  LoginViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 2/28/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    var account: Account!
    
    @IBAction func cancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showDisclaimer(_ sender: AnyObject) {
        let disclaimerAlert = UIAlertController(title: "Warning", message: "The Visilert app is designed for staff to practice setting/using the device. The app is not designed to save your education information. For core competency verification, you should complete all four (4) steps in order, and to completion. This will allow you to send the final check off document to your manager.", preferredStyle: .alert)
        disclaimerAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(disclaimerAlert, animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: AnyObject) {
        if (usernameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true) {
            let missingFieldsAlert = UIAlertController(title: "Missing Field", message: "Please fill in values for all the fields.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            missingFieldsAlert.addAction(ok)
            present(missingFieldsAlert, animated: true, completion: nil)
        } else {
            let appDelegate =
                UIApplication.shared.delegate as! AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Account",
                                                  in: managedObjectContext)
            let request = NSFetchRequest<NSFetchRequestResult>()
            request.entity = entityDescription
            let pred = NSPredicate(format: "(username = %@) AND (password = %@)", usernameTextField.text!, passwordTextField.text!)
            request.predicate = pred
            do {
                let list = try managedObjectContext.fetch(request)
                if list.count > 0 {
                    let user = list[0] as! Account
                    account = user
                    if (user.training != "Done") {
                        openTraining()
                    } else {
                        openDevice()
                    }
                } else {
                    let missingFieldsAlert = UIAlertController(title: "Authentication Error", message: "No user found.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    missingFieldsAlert.addAction(ok)
                    present(missingFieldsAlert, animated: true, completion: nil)
                }
            } catch let error as NSError {
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
    }
    
    func openTraining() {
        let viewController: TrainingViewController = self.storyboard?.instantiateViewController(withIdentifier: "guide") as! TrainingViewController
        viewController.user = account
        present(viewController, animated: true, completion: nil)
    }
    
    func openDevice() {
        let viewController: DeviceViewController = self.storyboard?.instantiateViewController(withIdentifier: "device") as! DeviceViewController
        viewController.closeButton?.isHidden = false
        present(viewController, animated: true, completion: nil)
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        
    }
}
