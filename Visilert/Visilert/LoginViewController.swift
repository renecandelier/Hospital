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
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func showDisclaimer(sender: AnyObject) {
        let disclaimerAlert = UIAlertController(title: "Warning", message: "The Visilert app is designed for staff to practice setting/using the device. The app is not designed to save your education information. For core competency verification, you should complete all four (4) steps in order, and to completion. This will allow you to send the final check off document to your manager.", preferredStyle: .Alert)
        disclaimerAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(disclaimerAlert, animated: true, completion: nil)
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        if (usernameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true) {
            let missingFieldsAlert = UIAlertController(title: "Missing Field", message: "Please fill in values for all the fields.", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
            missingFieldsAlert.addAction(ok)
            presentViewController(missingFieldsAlert, animated: true, completion: nil)
        } else {
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            let entityDescription =
                NSEntityDescription.entityForName("Account",
                                                  inManagedObjectContext: managedObjectContext)
            let request = NSFetchRequest()
            request.entity = entityDescription
            let pred = NSPredicate(format: "(username = %@) AND (password = %@)", usernameTextField.text!, passwordTextField.text!)
            request.predicate = pred
            do {
                let list = try managedObjectContext.executeFetchRequest(request)
                if list.count > 0 {
                    let user = list[0] as! Account
                    account = user
                    if (user.training != "Done") {
                        openTraining()
                    } else {
                        openDevice()
                    }
                } else {
                    let missingFieldsAlert = UIAlertController(title: "Authentication Error", message: "No user found.", preferredStyle: .Alert)
                    let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    missingFieldsAlert.addAction(ok)
                    presentViewController(missingFieldsAlert, animated: true, completion: nil)
                }
            } catch let error as NSError {
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
    }
    
    func openTraining() {
        let viewController: TrainingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("guide") as! TrainingViewController
        viewController.user = account
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    func openDevice() {
        let viewController: DeviceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("device") as! DeviceViewController
        viewController.closeButton?.hidden = false
        presentViewController(viewController, animated: true, completion: nil)
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        
    }
}
