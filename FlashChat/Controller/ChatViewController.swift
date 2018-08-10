//
//  ViewController.swift
//  Flash Chat
//
//  Created by Aditya Bhatia on 2018-07-24.
//  Copyright (c) 2018 adbht. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var messageArray = [Message]()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        //Set this view controller as the delegate and datasource
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //Set this view controller as the delegate of the text field
        messageTextfield.delegate = self
        
        //Register this view controller MessageCell.xib file
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retrieveMessages()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }

    //MARK: - TableView DataSource Methods
    
    //To cut the email addresses and print usernames to minimize clutter on the chat screen
    func senderCut (email : String) -> String {
        var senderName = String()
        for i in email {
            if i == "@" {
                break
            } else {
                senderName += "\(i)"
            }
        }
        return senderName
    }
    
    //To display latest texts
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messageArray.count-1, section: 0)
            self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = senderCut(email: messageArray[indexPath.row].sender)
        cell.senderUsername.textColor = UIColor.flatBlack()
        if messageArray[indexPath.row].sender == Auth.auth().currentUser?.email {
            cell.senderUsername.textAlignment = .right
            cell.messageBody.textAlignment = .right
            cell.messageBody.textColor = UIColor.flatMint()
        } else {
            cell.senderUsername.textAlignment = .left
            cell.messageBody.textAlignment = .left
            cell.messageBody.textColor = UIColor.flatTeal()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }

    //MARK:- TextField Delegate Methods

    func textFieldDidBeginEditing(_ textField: UITextField) {
        heightConstraint.constant = 308
        view.layoutIfNeeded()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        heightConstraint.constant = 50
        view.layoutIfNeeded()
        return true
    }
    
    //MARK: - Send & Recieve from Firebase
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        sendButton.isEnabled = false
        
        //Send the message to Firebase and save it in our database
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email, "MessageBody": messageTextfield.text!]
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            if error != nil {
                SVProgressHUD.showError(withStatus: "Error")
            } else {
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
    }
    
    func retrieveMessages() {
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! [String : String]
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
            self.scrollToBottom()
        }
    }
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //Log out the user and send them back to WelcomeViewController
        do {
            try Auth.auth().signOut()
            SVProgressHUD.showSuccess(withStatus: "Log out successful")
            navigationController?.popViewController(animated: true)
        } catch {
            SVProgressHUD.showError(withStatus: "Log out failed")
        }
    }
}
