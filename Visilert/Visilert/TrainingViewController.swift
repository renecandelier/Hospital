//
//  TrainingViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 2/28/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit
import MessageUI
import CoreData


class TrainingViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    var user: Account!
    
    @IBAction func closeButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func step1(_ sender: AnyObject) {
        let newController = (storyboard?.instantiateViewController(withIdentifier: "video"))! as! VideosViewController
        let oldController = childViewControllers.last! as UIViewController
        oldController.willMove(toParentViewController: nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        transition(from: oldController, to: newController, duration: 0.25, options: .transitionCrossDissolve, animations:{ () -> Void in
            // nothing needed here
            }, completion: { (finished) -> Void in
                oldController.removeFromParentViewController()
                newController.didMove(toParentViewController: self)
        })
    }
    
    @IBAction func step2Button(_ sender: AnyObject) {
        let newController = (storyboard?.instantiateViewController(withIdentifier: "device"))! as! DeviceViewController
        let oldController = childViewControllers.last! as UIViewController
        oldController.willMove(toParentViewController: nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        newController.closeButton.isHidden = true
        transition(from: oldController, to: newController, duration: 0.25, options: .transitionCrossDissolve, animations:{ () -> Void in
            // nothing needed here
            }, completion: { (finished) -> Void in
                oldController.removeFromParentViewController()
                newController.didMove(toParentViewController: self)

        })
    }
    
    @IBAction func step3(_ sender: AnyObject) {
        let newController = (storyboard?.instantiateViewController(withIdentifier: "RoundingCardsViewController"))! as! RoundingCardsViewController
        let oldController = childViewControllers.last! as UIViewController
        
        oldController.willMove(toParentViewController: nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        
        transition(from: oldController, to: newController, duration: 0.25, options: .transitionCrossDissolve, animations:{ () -> Void in
            // nothing needed here
            }, completion: { (finished) -> Void in
                oldController.removeFromParentViewController()
                newController.didMove(toParentViewController: self)
        })
        
    }
    
    @IBAction func step4(_ sender: AnyObject) {
        let emailAlert = UIAlertController(title: "", message: "Selecting YES indicates that you have gone through all the steps of the training", preferredStyle: .alert)
        emailAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        emailAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (UIAlertAction) -> Void in
            self.updateUserTraining()
            if let roundingCards = self.childViewControllers.last as? RoundingCardsViewController {
                self.sendEmail(roundingCards.view)
            } else {
                self.showDevice()
            }
        }))
        present(emailAlert, animated: true, completion: nil)
    }
    
    func showDevice() {
        let upcoming = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomeScreenViewController
        let navigationController = UINavigationController(rootViewController: upcoming)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func captureIamge(_ view: UIView) -> UIImage {
        let screenRect = UIScreen.main.bounds
        UIGraphicsBeginImageContext(screenRect.size)
        let ctx = UIGraphicsGetCurrentContext()
        UIColor.black.set()
        ctx!.fill(screenRect)
        view.layer.render(in: ctx!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func sendEmail(_ view: UIView) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            let image = captureIamge(view)
            let data = UIImageJPEGRepresentation(image, 1)
            mail.addAttachmentData(data!, mimeType: "image/jpeg", fileName: "Rounding Cards.jpg")
            present(mail, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
        let emailAlert = UIAlertController(title: "Email", message: "Email has been successfully sent!", preferredStyle: .alert)
        emailAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            self.showDevice()
        }))
        self.present(emailAlert, animated: true, completion: nil)        
    }
    
    
    func updateUserTraining() {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        user.training = "Done"
        do {
            try managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
