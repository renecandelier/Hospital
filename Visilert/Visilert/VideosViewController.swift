//
//  VideosViewController.swift
//  Visilert
//
//  Created by Rene Candelier on 2/28/16.
//  Copyright © 2016 CCE. All rights reserved.
//

import UIKit
import MediaPlayer

class VideosViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var videoWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoWebView.delegate = self
        videoWebView.scrollView.scrollsToTop = false;
        videoWebView.scrollView.isScrollEnabled = false;
        videoWebView.mediaPlaybackRequiresUserAction = true;
        loadChargingVideo()
    }
    
    @IBAction func chargingButton(_ sender: AnyObject) {
        loadChargingVideo()
    }
    
    func loadChargingVideo() {
        loadVideoWithLink("http://player.vimeo.com/video/115305575")
    }
    
    @IBAction func disinfectingButton(_ sender: AnyObject) {
        loadVideoWithLink("http://player.vimeo.com/video/115305573")
    }
    
    @IBAction func operatingButton(_ sender: AnyObject) {
        loadVideoWithLink("http://player.vimeo.com/video/115305571")
    }
    
    @IBAction func resettingButton(_ sender: AnyObject) {
        loadVideoWithLink("http://player.vimeo.com/video/115305569")
    }
    
    @IBAction func wallBraketButton(_ sender: AnyObject) {
        loadVideoWithLink("http://player.vimeo.com/video/115305568")
    }
    
    @IBAction func showNewOperatingVideo(_ sender: AnyObject) {
                loadVideoWithLink("http://player.vimeo.com/video/173109254")
    }
    func loadVideoWithLink (_ link: String) {
        let url = URL(string: link)!
        let request = URLRequest(url: url)
        videoWebView.loadRequest(request)
    }
}
