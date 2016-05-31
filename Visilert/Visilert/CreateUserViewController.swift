//
//  CreateUserViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 2/28/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit
import CoreData

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true , completion: nil)
    }
    
    @IBAction func createUserButton(sender: AnyObject) {
        if (usernameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || reEnterPasswordTextField.text?.isEmpty == true) {
            let missingFieldsAlert = UIAlertController(title: "Missing Field", message: "Please fill in values for all the fields.", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style: .Default, handler: nil)
            missingFieldsAlert.addAction(ok)
            presentViewController(missingFieldsAlert, animated: true, completion: nil)
        }
        if (passwordTextField.text != reEnterPasswordTextField.text) {
            let passwordAlert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .Alert)
            passwordAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(passwordAlert, animated: true, completion: nil)
        } else if (passwordTextField.text?.characters.count < 4) {
            let passwordAlert = UIAlertController(title: "Error", message: "Password must contain 4 or more characters.", preferredStyle: .Alert)
            passwordAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(passwordAlert, animated: true, completion: nil)
        } else {
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            let entityDescription =
            NSEntityDescription.entityForName("Account",
                inManagedObjectContext: managedObjectContext)
            let user = Account(entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            user.training = "Started"
            do {
                try managedObjectContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            self.navigationController?.popToRootViewControllerAnimated(false)
            let viewController: TrainingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("guide") as! TrainingViewController
            viewController.user = user
            presentViewController(viewController, animated: true, completion: nil)
        }
    }
    
}
