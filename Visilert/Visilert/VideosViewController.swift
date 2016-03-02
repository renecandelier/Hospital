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
        videoWebView.scrollView.scrollEnabled = false;
        videoWebView.mediaPlaybackRequiresUserAction = true;
        loadChargingVideo()
    }
    
    @IBAction func chargingButton(sender: AnyObject) {
        loadChargingVideo()
    }
    
    func loadChargingVideo() {
        loadVideoWithLink("http://player.vimeo.com/video/115305575")
    }
    
    @IBAction func disinfectingButton(sender: AnyObject) {
        loadVideoWithLink("http://player.vimeo.com/video/115305573")
    }
    
    @IBAction func operatingButton(sender: AnyObject) {
        loadVideoWithLink("http://player.vimeo.com/video/115305571")
    }
    
    @IBAction func resettingButton(sender: AnyObject) {
        loadVideoWithLink("http://player.vimeo.com/video/115305569")
    }
    
    @IBAction func wallBraketButton(sender: AnyObject) {
        loadVideoWithLink("http://player.vimeo.com/video/115305568")
    }
    
    func loadVideoWithLink (link: String) {
        let url: NSURL = NSURL(string: link)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        videoWebView.allowsInlineMediaPlayback = true
        videoWebView.loadRequest(request)
    }
}
