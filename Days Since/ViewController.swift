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
  
  override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
    settings()
  }

  
	override func viewDidLoad() {
		super.viewDidLoad()
    
    countLabel.font = UIFont.systemFontOfSize(800) // This is a fix because the max font size in the IB is 300.
    countLabel.text = String(daysSince())
    textLabel.text = daysSinceText()
	}
  
  func settings() {
    let title = NSLocalizedString("Settings", comment: "")
    let message = NSLocalizedString("Change the displayed text or reset the counter here.", comment: "")
    let resetDays = NSLocalizedString("Reset Days", comment: "")
    let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    alertController.addTextFieldWithConfigurationHandler { textField in
      // TODO: can the textfield have a wide input or multiple lines?
      textField.text = self.daysSinceText()
      textField.addTarget(self, action: "handleTextFieldTextDidChangeNotification:", forControlEvents: .EditingDidEnd)

    }
    
    let resetDaysAction = UIAlertAction(title: resetDays, style: .Default) { (button) -> Void in
      let defaults = NSUserDefaults.standardUserDefaults()
      defaults.setObject(NSDate(), forKey: "resetDate")
      self.countLabel.text = String(self.daysSince())
    }

    let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel, handler: nil)
    alertController.addAction(resetDaysAction)
    alertController.addAction(cancelAction)
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  func handleTextFieldTextDidChangeNotification(textField: UITextField) {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(textField.text, forKey: "labelText")
    textLabel.text = daysSinceText()
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: - User Defaults
  func daysSinceText() -> String {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let t = defaults.stringForKey("labelText") {
      return t
    } else {
      return NSLocalizedString("Days since someone pushed a broken build.", comment: "")
    }
  }
  
  func daysSince() -> Int {
    let defaults = NSUserDefaults.standardUserDefaults()
    if let d = defaults.objectForKey("resetDate") {
      let date = d as! NSDate
      let diff = date.timeIntervalSinceNow *  -1
      return Int(diff / (60 * 60 * 24))
    } else {
      return 0
    }
  }
}

