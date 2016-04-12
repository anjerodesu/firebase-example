//
//  Contact.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 12/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import Foundation
import Firebase

struct Contact {
	let key: String
	let firstName: String
	let lastName: String
	let userUID: String
	let contactsRef: Firebase
	
	init?(key: String, details: [String: String]) {
		guard let firstName = details[Constants.UserDefaultKeys.ContactData.FirstName], lastName = details[Constants.UserDefaultKeys.ContactData.LastName], userUID = details[Constants.UserDefaultKeys.ContactData.UserUID] else {
			// error happened
			// usually throws
			
			print("\(#function) {Line: \(#line)}: Details dictionary is incomplete")
			return nil
		}
		
		self.key = key
		self.firstName = firstName
		self.lastName = lastName
		self.userUID = userUID
		self.contactsRef = Firebase(url: Constants.FirebaseKeys.ContactsURL).childByAppendingPath(self.key)
	}
}

extension Contact {
	var details: [String: String] {
		return [
			Constants.UserDefaultKeys.ContactData.FirstName: self.firstName,
			Constants.UserDefaultKeys.ContactData.LastName: self.lastName,
			Constants.UserDefaultKeys.ContactData.UserUID: self.userUID
		]
	}
}
