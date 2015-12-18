//
//  HomeScreenViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 12/17/15.
//  Copyright © 2015 CCE. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let Device = UIDevice.currentDevice()
        
        let iosVersion = NSString(string: Device.systemVersion).doubleValue
        
        let iOS8 = iosVersion >= 8
            
            if (iOS8){
                presentedViewController?.presentingViewController?.providesPresentationContextTransitionStyle = true
                presentingViewController?.definesPresentationContext = true
            self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
//                [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
                
            }
            else {
                
                self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
                
                
            }
    }
    
   }
