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
    }
    
    @IBAction func sendFile(sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            if let pdf = NSBundle.mainBundle().pathForResource(pdfFile, ofType: "pdf")  {
                
                if let fileData = NSData(contentsOfFile: pdf) {
                    print("File data loaded.")
                    mail.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "\(pdfFile).pdf")
                }
            }
            presentViewController(mail, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
