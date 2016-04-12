//
//  AddContactViewController.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 12/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import UIKit
import Firebase

class AddContactViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	@IBOutlet weak var saveContactButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension AddContactViewController {
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if textField.isEqual(firstNameTextField) {
			firstNameTextField.resignFirstResponder()
			lastNameTextField.becomeFirstResponder()
		} else {
			lastNameTextField.resignFirstResponder()
			if let firstName = firstNameTextField.text, lastName = lastNameTextField.text, userUID = NSUserDefaults.standardUserDefaults().valueForKey(Constants.UserDefaultKeys.AuthData.UserUID) as? String {
				createNewContact([
					Constants.UserDefaultKeys.ContactData.FirstName: firstName,
					Constants.UserDefaultKeys.ContactData.LastName: lastName,
					Constants.UserDefaultKeys.ContactData.UserUID: userUID
				])
			}
		}
		
		return true
	}
}

extension AddContactViewController {
	@IBAction func saveContactButtonPressed(sender: UIButton) {
		if let firstName = firstNameTextField.text, lastName = lastNameTextField.text, userUID = NSUserDefaults.standardUserDefaults().valueForKey(Constants.UserDefaultKeys.AuthData.UserUID) as? String {
			createNewContact([
				Constants.UserDefaultKeys.ContactData.FirstName: firstName,
				Constants.UserDefaultKeys.ContactData.LastName: lastName,
				Constants.UserDefaultKeys.ContactData.UserUID: userUID
			])
		}
	}
}

extension AddContactViewController {
	private func createNewContact(details: [String: String]) {
		let newContact = Firebase(url: Constants.FirebaseKeys.ContactsURL).childByAutoId()
		let contact = Contact(key: newContact.key, details: details)
		newContact.setValue(contact!.details)
		self.navigationController?.popViewControllerAnimated(true)
	}
}
