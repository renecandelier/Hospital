//
//  TrainingViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 2/28/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
    
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
        let newController = (storyboard?.instantiateViewControllerWithIdentifier("rounding"))! as! RoundingChecklistTableViewController
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
        let newController = (storyboard?.instantiateViewControllerWithIdentifier("card"))! as! PatientChecklistTableViewController
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
    
    @IBAction func step5(sender: AnyObject) {
        let emailAlert = UIAlertController(title: "", message: "Selecting YES indicates that you have gone through all the steps of the training", preferredStyle: .Alert)
        emailAlert.addAction(UIAlertAction(title: "NO", style: .Cancel, handler: nil))
        emailAlert.addAction(UIAlertAction(title: "YES", style: .Default, handler: { (UIAlertAction) -> Void in
            self.showDevice()
        }))
        presentViewController(emailAlert, animated: true, completion: nil)
    }
    
    func showDevice() {
        let viewController: DeviceViewController = self.storyboard?.instantiateViewControllerWithIdentifier("device") as! DeviceViewController
        presentViewController(viewController, animated: true, completion: nil)
    }
    

}
