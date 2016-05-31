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
    
    @IBAction func closeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func step1(sender: AnyObject) {
        let newController = (storyboard?.instantiateViewControllerWithIdentifier("video"))! as! VideosViewController
        let oldController = childViewControllers.last! as UIViewController
        oldController.willMoveToParentViewController(nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        transitionFromViewController(oldController, toViewController: newController, duration: 0.25, options: .TransitionCrossDissolve, animations:{ () -> Void in
            // nothing needed here
            }, completion: { (finished) -> Void in
                oldController.removeFromParentViewController()
                newController.didMoveToParentViewController(self)
        })
    }
    
    @IBAction func step2Button(sender: AnyObject) {
        let newController = (storyboard?.instantiateViewControllerWithIdentifier("device"))! as! DeviceViewController
        let oldController = childViewControllers.last! as UIViewController
        oldController.willMoveToParentViewController(nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        transitionFromViewController(oldController, toViewController: newController, duration: 0.25, options: .TransitionCrossDissolve, animations:{ () -> Void in
            // nothing needed here
            }, completion: { (finished) -> Void in
                oldController.removeFromParentViewController()
                newController.didMoveToParentViewController(self)
        })
    }
    @IBAction func step3(sender: AnyObject) {
        let newController = (storyboard?.instantiateViewControllerWithIdentifier("RoundingCardsViewController"))! as! RoundingCardsViewController
        //        newController.pdfFile = "Visilert Rounding Employer Checklist"
        let oldController = childViewControllers.last! as UIViewController
        
        oldController.willMoveToParentViewController(nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        
        transitionFromViewController(oldController, toViewController: newController, duration: 0.25, options: .TransitionCrossDissolve, animations:{ () -> Void in
            // nothing needed here
            }, completion: { (finished) -> Void in
                oldController.removeFromParentViewController()
                newController.didMoveToParentViewController(self)
        })
        
    }
    
    @IBAction func step4(sender: AnyObject) {
        let emailAlert = UIAlertController(title: "", message: "Selecting YES indicates that you have gone through all the steps of the training", preferredStyle: .Alert)
        emailAlert.addAction(UIAlertAction(title: "NO", style: .Cancel, handler: nil))
        emailAlert.addAction(UIAlertAction(title: "YES", style: .Default, handler: { (UIAlertAction) -> Void in
            self.updateUserTraining()
            if let roundingCards = self.childViewControllers.last as? RoundingCardsViewController {
                self.sendEmail(roundingCards.view)
            } else {
                self.showDevice()
            }
        }))
        presentViewController(emailAlert, animated: true, completion: nil)
    }
    
    func showDevice() {
        let upcoming = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! HomeScreenViewController
        let navigationController = UINavigationController(rootViewController: upcoming)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func captureIamge(view: UIView) -> UIImage {
        let screenRect = UIScreen.mainScreen().bounds
        UIGraphicsBeginImageContext(screenRect.size)
        let ctx = UIGraphicsGetCurrentContext()
        UIColor.blackColor().set()
        CGContextFillRect(ctx, screenRect)
        view.layer.renderInContext(ctx!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func sendEmail(view: UIView) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            let image = captureIamge(view)
            let data = UIImageJPEGRepresentation(image, 1)
            mail.addAttachmentData(data!, mimeType: "image/jpeg", fileName: "Rounding Cards.jpg")
            presentViewController(mail, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
        let emailAlert = UIAlertController(title: "Email", message: "Email has been successfully sent!", preferredStyle: .Alert)
        emailAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (_) in
            self.showDevice()
        }))
        self.presentViewController(emailAlert, animated: true, completion: nil)        
    }
    
    
    func updateUserTraining() {
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        user.training = "Done"
        do {
            try managedObjectContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
