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
        if let pdf = Bundle.main.url(forResource: pdfFile, withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = URLRequest(url: pdf)
            webView.loadRequest(req)
        }
    }
    
    @IBAction func sendFile(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            if let pdf = Bundle.main.path(forResource: pdfFile, ofType: "pdf")  {
                
                if let fileData = try? Data(contentsOf: URL(fileURLWithPath: pdf)) {
                    print("File data loaded.")
                    mail.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "\(pdfFile).pdf")
                }
            }
            present(mail, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }

}
