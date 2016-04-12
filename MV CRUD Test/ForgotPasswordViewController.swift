//
//  ForgotPasswordViewController.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 12/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var resetPasswordButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ForgotPasswordViewController {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if let email = emailTextField.text {
			resetPassword(email)
		}
		
		return true
	}
}

extension ForgotPasswordViewController {
	@IBAction func resetPasswordButtonPressed(sender: UIButton) {
		if let email = emailTextField.text {
			resetPassword(email)
		}
	}
}

extension ForgotPasswordViewController {
	private func resetPassword(email: String) {
		Firebase(url: Constants.FirebaseKeys.DatabaseURL).resetPasswordForUser(email, withCompletionBlock: { error in
			guard error == nil else {
				let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
				let alertController = UIAlertController(title: "Error", message: error.description, preferredStyle: .Alert)
				alertController.addAction(action)
				self.presentViewController(alertController, animated: true, completion: nil)
				
				return
			}
			
			let action = UIAlertAction(title: "Done", style: .Default, handler: { action in
				if let navController = self.navigationController {
					navController.popViewControllerAnimated(true)
				}
			})
			let alertController = UIAlertController(title: "Reset Password", message: "Password reset authorisation has been sent successfully.", preferredStyle: .Alert)
			alertController.addAction(action)
			self.presentViewController(alertController, animated: true, completion: nil)
		})
	}
}
