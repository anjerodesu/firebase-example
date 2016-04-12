//
//  ListViewController.swift
//  MV CRUD Test
//
//  Created by Angelo Villegas on 12/4/16.
//  Copyright © 2016 Angelo Villegas. All rights reserved.
//

import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var contacts: [Contact] = []
	var contactToEdit: Contact!
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		let plusBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addContactBarButtonItemPressed))
		self.navigationItem.rightBarButtonItem = plusBarButtonItem
		
		Firebase(url: Constants.FirebaseKeys.ContactsURL).observeEventType(.Value, withBlock: { snapshot in
			print("\(self) \(#function) {Line: \(#line)}: \(snapshot.value)")
			self.contacts = []
			if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
				for snap in snapshots {
					if let dictionary = snap.value as? [String: String] {
						let key = snap.key
						let contact = Contact(key: key, details: dictionary)
						self.contacts.append(contact!)
						self.tableView.reloadData()
					}
				}
			}
		}, withCancelBlock: { error in
			print("\(self) \(#function) {Line: \(#line)}: \(error.description)")
		})
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ListViewController {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return contacts.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let CellIdentifier = "CellIdentifier"
		var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
		if cell == nil {
			cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
		}
		
		let contact = contacts[indexPath.row]
		cell?.textLabel!.text = "\(contact.firstName) \(contact.lastName)"
		cell?.accessoryType = .DisclosureIndicator
		
		return cell!
	}
}

extension ListViewController {
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		contactToEdit = contacts[indexPath.row]
		performSegueWithIdentifier("ListToEditSegueIdentifier", sender: self)
		
	}
	
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			let contact = contacts[indexPath.row]
			contacts.removeAtIndex(indexPath.row)
			contact.contactsRef.removeValue()
		}
	}
}

extension ListViewController {
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let controller = segue.destinationViewController as? EditContactViewController {
			controller.contact = contactToEdit
		}
	}
}

extension ListViewController {
	func addContactBarButtonItemPressed() {
		self.performSegueWithIdentifier("ListToAddSegueIdentifier", sender: self)
	}
}
