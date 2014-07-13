//
//  DetailVC.swift
//  XMLParser-Tutorial
//
//  Created by Benjamin Herzog on 13.07.14.
//  Copyright (c) 2014 Benjamin Herzog. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet var webView: UIWebView
    var url: NSURL?
    var titleString: String?
    
    override func viewDidLoad() {
        if titleString {
            title = titleString!
        }
        if url {
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
        }
    }
    

}
