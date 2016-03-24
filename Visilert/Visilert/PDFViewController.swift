//
//  OperatingStepsViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 3/3/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit
import MessageUI

class PDFViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var webView: UIWebView!
    var pdfFile = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdf = NSBundle.mainBundle().URLForResource(pdfFile, withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = NSURLRequest(URL: pdf)
            webView.loadRequest(req)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendFile(sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["dpreston10@gmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            if let pdf = NSBundle.mainBundle().pathForResource(pdfFile, ofType: "pdf")  {
                
                if let fileData = NSData(contentsOfFile: pdf) {
                    print("File data loaded.")
                    mail.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "file.pdf")
                }
            }
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
        
        
//        // locate folder containing pdf file
//        let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
//        
//        let pdfFileName = documentsPath.stringByAppendingPathComponent("chart.pdf")
//        let fileData = NSData(contentsOfFile: pdfFileName)
//        mc.addAttachmentData(fileData, mimeType: "application/pdf", fileName: chart)
    }

}
