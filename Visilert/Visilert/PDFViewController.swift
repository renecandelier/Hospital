//
//  OperatingStepsViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 3/3/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {

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

}
