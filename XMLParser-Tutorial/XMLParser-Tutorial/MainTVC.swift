//
//  MainTVC.swift
//  XMLParser-Tutorial
//
//  Created by Benjamin Herzog on 13.07.14.
//  Copyright (c) 2014 Benjamin Herzog. All rights reserved.
//

import UIKit

let kURL = NSURL(string: "http://www.stern.de/feed/standard/all/")!

class MainTVC: UITableViewController, XMLParserDelegate {
    
    var parser = XMLParser(url: kURL)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stern.de RSS-Feed"
        parser.delegate = self
        parser.parse {
            self.tableView.reloadData()
        }
    }
    
    func XMLParserError(parser: XMLParser, error: String) {
        println(error)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parser.objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.textLabel?.text = parser.objects[indexPath.row]["title"]
        cell.textLabel?.numberOfLines = 3
        cell.textLabel?.lineBreakMode = .ByWordWrapping
        cell.textLabel?.textColor = UIColor.blueColor()
        cell.detailTextLabel?.text = parser.objects[indexPath.row]["description"]
        cell.detailTextLabel?.numberOfLines = 2
        cell.detailTextLabel?.lineBreakMode = .ByWordWrapping
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detail" {
            (segue.destinationViewController as DetailVC).url = NSURL(string: parser.objects[tableView.indexPathForCell(sender as UITableViewCell)!.row]["link"]!)
            (segue.destinationViewController as DetailVC).titleString = parser.objects[tableView.indexPathForCell(sender as UITableViewCell)!.row]["title"]
        }
    }

    @IBAction func refreshButtonPressed(sender: UIBarButtonItem) {
        parser.deleteObjects()
        self.tableView.reloadData()
        parser.parse {
            self.tableView.reloadData()
        }
    }
}

























