//
//  HomeScreenViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 12/17/15.
//  Copyright © 2015 CCE. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    // MARK: - Properties
    var titleForNextView = ""
    var pdf = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func presentHowItWorks(_ sender: UIButton) {
        titleForNextView = "How It Works"
        pdf = "How It Works"
        performSegue(withIdentifier: "PDF", sender: self)
    }
    
    @IBAction func presentOperatingInstructions(_ sender: UIButton) {
        titleForNextView = "Operating Instructions"
        pdf = "Operating Instructions"
        performSegue(withIdentifier: "PDF", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PDF" {
            let upcoming = segue.destination as! PDFViewController
                upcoming.title = titleForNextView
                upcoming.pdfFile = pdf
        }
    }
}
