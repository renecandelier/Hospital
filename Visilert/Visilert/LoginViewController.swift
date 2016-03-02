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
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
                    if (user.training?.integerValue < 5) {
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
        
        presentViewController(viewController, animated: true, completion: nil)
//        performSegueWithIdentifier("training", sender: self)
    }
    
    func openDevice() {
        

//                    self.navigationController?.pushViewController(viewController, animated: true)
//                    performSegueWithIdentifier("training", sender: self)
//        
//        dismissViewControllerAnimated(true) { () -> Void in
        
            
            
            let viewController: DeviceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("device") as! DeviceViewController
            
            presentViewController(viewController, animated: true, completion: nil)
//            let viewController: DeviceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("device") as! DeviceViewController
//            self.navigationController?.pushViewController(viewController, animated: true)

            
        
//        }
        
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("device") as! DeviceViewController
//        
//        let nav = UINavigationController(rootViewController: self)
//        nav.pushViewController(nextViewController, animated:false)
//        self.presentViewController(nav, animated:true, completion:nil)
//        
    }
}
