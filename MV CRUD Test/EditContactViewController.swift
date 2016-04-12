//
//  EditContactViewController.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 12/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import UIKit
import Firebase

class EditContactViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var editContactButton: UIButton!
	
	internal var contact: Contact!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		firstNameTextField.text = contact.firstName
		lastNameTextField.text = contact.lastName
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension EditContactViewController {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if textField.isEqual(firstNameTextField) {
			firstNameTextField.resignFirstResponder()
			lastNameTextField.becomeFirstResponder()
		} else {
			lastNameTextField.resignFirstResponder()
			if let firstName = firstNameTextField.text, lastName = lastNameTextField.text, userUID = NSUserDefaults.standardUserDefaults().valueForKey(Constants.UserDefaultKeys.AuthData.UserUID) as? String {
				updateContact([
					Constants.UserDefaultKeys.ContactData.FirstName: firstName,
					Constants.UserDefaultKeys.ContactData.LastName: lastName,
					Constants.UserDefaultKeys.ContactData.UserUID: userUID
				])
			}
		}
		
		return true
	}
}

extension EditContactViewController {
	@IBAction func editContactButtonPressed(sender: UIButton) {
		if let firstName = firstNameTextField.text, lastName = lastNameTextField.text, userUID = NSUserDefaults.standardUserDefaults().valueForKey(Constants.UserDefaultKeys.AuthData.UserUID) as? String {
			updateContact([
				Constants.UserDefaultKeys.ContactData.FirstName: firstName,
				Constants.UserDefaultKeys.ContactData.LastName: lastName,
				Constants.UserDefaultKeys.ContactData.UserUID: userUID
			])
		}
	}
}

extension EditContactViewController {
	private func updateContact(details: [String: String]) {
		contact.contactsRef.updateChildValues(details)
		self.navigationController?.popViewControllerAnimated(true)
	}
}
