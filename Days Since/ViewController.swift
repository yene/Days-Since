// 
// ViewController.swift
// Days Since
// 
// Created by Yannick Weiss on 27/11/15.
// Copyright © 2015 Yannick Weiss. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var countLabel: UILabel!
	@IBAction func resetCount(sender: AnyObject) {
		let defaults = NSUserDefaults.standardUserDefaults()
		defaults.setObject(NSDate(), forKey: "resetDate")


	}
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let defaults = NSUserDefaults.standardUserDefaults()
    if let d = defaults.objectForKey("resetDate") {
      let date = d as! NSDate
      let diff = date.timeIntervalSinceNow *  -1
      let days = Int(diff / (60 * 60 * 24))
      countLabel.text = String(days)
    }
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

