//
//  ResetViewController.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 11/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import UIKit
import Firebase

class ResetViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var currentTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmTextField: UITextField!
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

extension ResetViewController {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if textField.isEqual(currentTextField) {
			currentTextField.resignFirstResponder()
			passwordTextField.becomeFirstResponder()
		} else if (textField.isEqual(passwordTextField)) {
			passwordTextField.resignFirstResponder()
			confirmTextField.becomeFirstResponder()
		} else {
			confirmTextField.resignFirstResponder()
			if let email = NSUserDefaults.standardUserDefaults().valueForKey(Constants.UserDefaultKeys.AuthData.UserEmail) as? String, current = currentTextField.text, password = passwordTextField.text, confirm = confirmTextField.text {
				if password == confirm {
					resetPassword(email, oldPassword: current, newPassword: password)
				} else {
					passwordDoNotMatch()
				}
			}
		}
		
		return true
	}
}

extension ResetViewController {
	@IBAction func resetPasswordButtonPressed(sender: UIButton) {
		if let email = NSUserDefaults.standardUserDefaults().valueForKey(Constants.UserDefaultKeys.AuthData.UserEmail) as? String, current = currentTextField.text, password = passwordTextField.text, confirm = confirmTextField.text {
			if password == confirm {
				resetPassword(email, oldPassword: current, newPassword: password)
			} else {
				passwordDoNotMatch()
			}
		}
	}
}

extension ResetViewController {
	private func resetPassword(email: String, oldPassword: String, newPassword: String) {
		Firebase(url: Constants.FirebaseKeys.DatabaseURL).changePasswordForUser(email, fromOld: oldPassword, toNew: newPassword, withCompletionBlock: { error in
			guard error == nil else {
				let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
				let alertController = UIAlertController(title: "Error", message: error.description, preferredStyle: .Alert)
				alertController.addAction(action)
				self.showViewController(alertController, sender: self)
				
				return
			}
			
			if let navController = self.navigationController {
				navController.popViewControllerAnimated(true)
			}
		})
	}
	
	private func passwordDoNotMatch() {
		let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
		let alertController = UIAlertController(title: "Error", message: "Your passwords do not match", preferredStyle: .Alert)
		alertController.addAction(action)
		self.showViewController(alertController, sender: self)
	}
}
