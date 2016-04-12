//
//  WelcomeViewController.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 11/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
	
	@IBOutlet weak var welcomeLabel: UILabel!
	@IBOutlet weak var logoutButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.navigationItem.hidesBackButton = true
		
		if let userEmail = NSUserDefaults.standardUserDefaults().valueForKey(Constants.UserDefaultKeys.AuthData.UserEmail) as? String {
			welcomeLabel.text = "\(userEmail)"
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension WelcomeViewController {
	@IBAction func logoutButtonPressed(sender: UIButton) {
		Firebase(url: Constants.FirebaseKeys.DatabaseURL).unauth()
		self.navigationController?.popViewControllerAnimated(true)
	}
}
