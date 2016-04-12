//
//  SignUpViewController.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 11/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var confirmTextField: UITextField!
	@IBOutlet weak var createAccountButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension SignUpViewController {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if textField.isEqual(emailTextField) {
			emailTextField.resignFirstResponder()
			passwordTextField.becomeFirstResponder()
		} else if (textField.isEqual(passwordTextField)) {
			passwordTextField.resignFirstResponder()
			confirmTextField.becomeFirstResponder()
		} else {
			confirmTextField.resignFirstResponder()
			if let email = NSUserDefaults.standardUserDefaults().valueForKey(Constants.UserDefaultKeys.AuthData.UserEmail) as? String, password = passwordTextField.text, confirm = confirmTextField.text {
				if password == confirm {
					createAccount(email, password: password)
				} else {
					passwordDoNotMatch()
				}
			}
		}
		
		return true
	}
}

extension SignUpViewController {
	@IBAction func createAccountButtonPressed(sender: UIButton) {
		if let email = emailTextField.text, password = passwordTextField.text, confirm = confirmTextField.text {
			if password == confirm {
				createAccount(email, password: password)
			} else {
				passwordDoNotMatch()
			}
		}
	}
}

extension SignUpViewController {
	private func createAccount(email: String, password: String) {
		Firebase(url: Constants.FirebaseKeys.DatabaseURL).createUser(email, password: password, withValueCompletionBlock: { error, result in
			guard error == nil else {
				let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
				let alertController = UIAlertController(title: "Error", message: error.description, preferredStyle: .Alert)
				alertController.addAction(action)
				self.presentViewController(alertController, animated: true, completion: nil)
				
				return
			}
			
			if let navController = self.navigationController {
				navController.popViewControllerAnimated(true)
			}
		})
	}
	
	private func passwordDoNotMatch() {
		let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
		let alertController = UIAlertController(title: "Error", message: "Your password do not match", preferredStyle: .Alert)
		alertController.addAction(action)
		self.presentViewController(alertController, animated: true, completion: nil)
	}
}
