// 
// ViewController.swift
// Days Since
// 
// Created by Yannick Weiss on 27/11/15.
// Copyright © 2015 Yannick Weiss. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var countLabel: UILabel!
	@IBAction func resetCount(sender: AnyObject) {
    settings()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
    
    countLabel.font = UIFont.systemFontOfSize(800)
    
		// Do any additional setup after loading the view, typically from a nib.
		let defaults = NSUserDefaults.standardUserDefaults()
    if let d = defaults.objectForKey("resetDate") {
      let date = d as! NSDate
      let diff = date.timeIntervalSinceNow *  -1
      let days = Int(diff / (60 * 60 * 24))
      countLabel.text = String(days)
    }
    
    textLabel.text = daysSinceText()
	}
  
  func daysSinceText() -> String {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let t = defaults.stringForKey("labelText") {
      return t
    } else {
      return NSLocalizedString("Days since someone pushed a broken build.", comment: "")
    }
  }

  func settings() {
    let title = NSLocalizedString("Settings", comment: "")
    let resetDays = NSLocalizedString("Reset Days", comment: "")
    let changeText = NSLocalizedString("Change Text", comment: "")
    let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
    
    let alertController = UIAlertController(title: title, message: "", preferredStyle: .Alert)
    
    alertController.addTextFieldWithConfigurationHandler { textField in
      textField.text = self.daysSinceText()
    }
    
    let resetDaysAction = UIAlertAction(title: resetDays, style: .Default) { (button) -> Void in
      let defaults = NSUserDefaults.standardUserDefaults()
      defaults.setObject(NSDate(), forKey: "resetDate")
    }
    let changeTextAction = UIAlertAction(title: changeText, style: .Default) { (button) -> Void in
      // ask for new text
    }
    let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel) { _ in
      // do nothing?
    }
    alertController.addAction(resetDaysAction)
    //alertController.addAction(changeTextAction)
    alertController.addAction(cancelAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

