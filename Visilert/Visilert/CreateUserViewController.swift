//
//  CreateUserViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 2/28/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit
import CoreData
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    @IBAction func cancelButton(_ sender: AnyObject) {
        dismiss(animated: true , completion: nil)
    }
    
    @IBAction func createUserButton(_ sender: AnyObject) {
        if (usernameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || reEnterPasswordTextField.text?.isEmpty == true) {
            let missingFieldsAlert = UIAlertController(title: "Missing Field", message: "Please fill in values for all the fields.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            missingFieldsAlert.addAction(ok)
            present(missingFieldsAlert, animated: true, completion: nil)
        }
        if (passwordTextField.text != reEnterPasswordTextField.text) {
            let passwordAlert = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            passwordAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(passwordAlert, animated: true, completion: nil)
        } else if (passwordTextField.text?.characters.count < 4) {
            let passwordAlert = UIAlertController(title: "Error", message: "Password must contain 4 or more characters.", preferredStyle: .alert)
            passwordAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(passwordAlert, animated: true, completion: nil)
        } else {
            let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
            let managedObjectContext = appDelegate.managedObjectContext
            let entityDescription =
            NSEntityDescription.entity(forEntityName: "Account",
                in: managedObjectContext)
            let user = Account(entity: entityDescription!,
                insertInto: managedObjectContext)
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            user.training = "Started"
            do {
                try managedObjectContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            self.navigationController?.popToRootViewController(animated: false)
            let viewController: TrainingViewController = self.storyboard?.instantiateViewController(withIdentifier: "guide") as! TrainingViewController
            viewController.user = user
            present(viewController, animated: true, completion: nil)
        }
    }
    
}
