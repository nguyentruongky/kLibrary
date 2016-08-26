//
//  ContactPickerIntention.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import AddressBook

struct Contact {
    
    var name = ""
    var phone = ""
}

class ContactPickerIntention: NSObject, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var sourceContactsBook = [String : [Contact]]()
    private var contactsBook = [String : [Contact]]()
    private var contactGroup = [Contact]()
    
    private var peopleSectionTitles = [String]()
    
    private func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
        
    func getAllContacts() {
        
        setupUI()
        
        // make sure user hadn't previously denied access
        let status = ABAddressBookGetAuthorizationStatus()
        if status == .Denied || status == .Restricted {
            // user previously denied, to tell them to fix that in settings
            return
        }
      
        var error: Unmanaged<CFError>?
        let addressBook: ABAddressBook? = ABAddressBookCreateWithOptions(nil, &error)?.takeRetainedValue()

        // request permission to use it
        ABAddressBookRequestAccessWithCompletion(addressBook) {
            granted, error in
            
            if granted == false {
                // warn the user that because they just denied permission, this functionality won't work
                // also let them know that they have to fix this in settings
            
                return
            }

            var currentCharacter = "A"
            
            let allContacts = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as Array

            for i in 0 ..< allContacts.count {
                
                let currentContact: ABRecordRef = allContacts[i]
                let currentName = self.getNameFromContact(currentContact)
                let nameFirstChar = self.getNameFirstCharFromString(currentName)
                
                if i == 0 {
                    
                    currentCharacter = nameFirstChar
                }
                
                if nameFirstChar != currentCharacter {

                    self.storeContactToBookWithGroup(currentCharacter)
                    currentCharacter = nameFirstChar
                    self.contactGroup = [Contact]()
                }
                
                let phoneNumberList = self.getPhoneNumbersFromContact(currentContact)
                if let list = phoneNumberList {
                    
                    for phone in list {
                        
                        self.saveContactToGroupWithName(currentName, phone: phone)
                    }
                }
            }
            
            self.prepareDataForTableView()
        }
    }
    
    private func setupUI() {
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getNameFromContact(currentContact: ABRecordRef) -> String {
        
        let firstName = ABRecordCopyValue(currentContact, kABPersonFirstNameProperty)
        let lastName = ABRecordCopyValue(currentContact, kABPersonLastNameProperty)
        
        var currentName = ""
        if firstName == nil && lastName == nil { // prevent anonymous contact
            
            currentName = ""
        }
        else {
            
            currentName = ABRecordCopyCompositeName(currentContact).takeRetainedValue() as String
        }
        
        return currentName
    }
    
    private func getNameFirstCharFromString(name: String) -> String {
        
        var nameFirstChar = name
        if name == "" {
            
            nameFirstChar = "#"
        }
        else {
            
            nameFirstChar = (name as NSString).substringToIndex(1).uppercaseString
        }
        
        if nameFirstChar.isALetter() == false {
            
            nameFirstChar = "#"
        }
        
        return nameFirstChar
    }
    
    func getEmail(currentContact: ABRecordRef) -> String {
        
        let email:ABMultiValueRef = ABRecordCopyValue(currentContact, kABPersonEmailProperty).takeRetainedValue()
        
        var emailString = ""
        
        if ABMultiValueGetCount(email) > 0{
        
            emailString = ABMultiValueCopyValueAtIndex(email, 0).takeRetainedValue() as! String
        }

        return emailString
    }
    
    private func getPhoneNumbersFromContact(currentContact: ABRecordRef) -> [String]? {
        
        var phoneNumberList = [String]()
        let phones:ABMultiValueRef = ABRecordCopyValue(currentContact, kABPersonPhoneProperty).takeRetainedValue()
        let count = ABMultiValueGetCount(phones)
        for j in 0 ..< count {
            let mobileLabel = ABMultiValueCopyLabelAtIndex(phones, j).takeRetainedValue()
            
            if mobileLabel == kABPersonPhoneMobileLabel ||
                mobileLabel == kABHomeLabel ||
                mobileLabel == kABPersonPhoneMainLabel ||
                mobileLabel == kABPersonPhoneIPhoneLabel ||
                mobileLabel == kABOtherLabel ||
                mobileLabel == kABWorkLabel {
                    
                    let phone = ABMultiValueCopyValueAtIndex(phones, j).takeRetainedValue() as! String
                    phoneNumberList.append(phone)
            }
        }
        
        return phoneNumberList
    }
    
    private func prepareDataForTableView() {
        
        self.peopleSectionTitles = [String](self.contactsBook.keys)
        self.peopleSectionTitles = self.peopleSectionTitles.sort()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.tableView.reloadData()
        })
    }
    
    private func saveContactToGroupWithName(name: String, phone: String) {
        
        var contactItem = Contact()
        contactItem.name = name
        contactItem.phone = phone
        self.contactGroup.append(contactItem)
    }
    
    private func storeContactToBookWithGroup(currentCharacter: String) {
        
        if let group = contactsBook[currentCharacter] {
            
            for contact in group {
                
                contactGroup.append(contact)
            }
        }

        contactGroup.sortInPlace { (contact1, contact2) -> Bool in
            
            if contact1.name < contact2.name {
                
                return true
            }
            else {
                
                return false
            }
        }
        
        contactsBook[currentCharacter] = contactGroup
        sourceContactsBook = contactsBook
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return peopleSectionTitles.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionTitle = peopleSectionTitles[section]
        return contactsBook[sectionTitle]!.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return peopleSectionTitles[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath)
        
        let person = getPersonInfo(indexPath)
        
        let name = person.name

        if name == "" {
            
            cell.textLabel?.text = person.phone
            cell.detailTextLabel?.text = ""
        }
        else {
            
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = person.phone
        }
        
        return cell
    }

    func getPersonInfo(indexPath: NSIndexPath) -> Contact {
        
        let sectionTitle = peopleSectionTitles[indexPath.section]
        return contactsBook[sectionTitle]![indexPath.row]
    }

    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        return peopleSectionTitles
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        return peopleSectionTitles.indexOf(title)!
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count == 0 {
            
            contactsBook = sourceContactsBook
        }
        else {
            
            var allContacts = [Contact]()
            for contacts in sourceContactsBook.values {
                
                allContacts.appendContentsOf(contacts)
            }
            
            let foundContacts = allContacts.filter({ (contact) -> Bool in
                
                contact.name.containsString(searchText)
            })
            
            contactsBook = ["" : foundContacts]
        }
        
        prepareDataForTableView()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    
}

extension String {

    func isALetter() -> Bool {
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return letters.containsString(self)
    }
}


