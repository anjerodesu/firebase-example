//
//  LoginViewController.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 11/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		emailTextField.text = ""
		passwordTextField.text = ""
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension LoginViewController {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if textField.isEqual(emailTextField) {
			emailTextField.resignFirstResponder()
			passwordTextField.becomeFirstResponder()
		} else {
			passwordTextField.resignFirstResponder()
			if let username = emailTextField.text, password = passwordTextField.text {
				authenticateUser(username, password: password)
			}
		}
		
		return true
	}
}

extension LoginViewController {
	@IBAction func loginButtonPressed(sender: UIButton) {
		if let username = emailTextField.text, password = passwordTextField.text {
			authenticateUser(username, password: password)
		}
	}
}

extension LoginViewController {
	private func authenticateUser(email: String, password: String) {
		Firebase(url: Constants.FirebaseKeys.DatabaseURL).authUser(emailTextField.text, password: passwordTextField.text, withCompletionBlock: { error, authData in
			guard error == nil else {
				// error happened
				// usually throw
				return
			}
			
			NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: Constants.UserDefaultKeys.AuthData.UserUID)
			NSUserDefaults.standardUserDefaults().setValue(authData.providerData["email"], forKey: Constants.UserDefaultKeys.AuthData.UserEmail)
			self.performSegueWithIdentifier("LoginSegueIdentifier", sender: self)
		})
	}
}
