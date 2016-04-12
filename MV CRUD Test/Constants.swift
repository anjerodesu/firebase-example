//
//  Constants.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 12/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import Foundation

struct Constants {
	struct FirebaseKeys {
		static let DatabaseURL = "https://intense-heat-1445.firebaseio.com/"
		static let ContactsURL = DatabaseURL.stringByAppendingString("contacts")
	}
	
	struct UserDefaultKeys {
		struct AuthData {
			static let UserUID = "kUserUID"
			static let UserEmail = "kUserEmail"
		}
		
		struct ContactData {
			static let FirstName = "firstName"
			static let LastName = "lastName"
			static let UserUID = "userUID"
		}
	}
}
