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
    
    var messageArray = [Message]()                          //Creating an object from the Message() Class
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!     //This constraint is needed to bring up the TextField when it is clicked to create space for keyboard to be poppped
    @IBOutlet var sendButton: UIButton!                     
    @IBOutlet var messageTextfield: UITextField!    
    @IBOutlet var messageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:true);    //By default, there is a back button on the left of navigation bar which is redundant as there is a Log Out button. Hence this is needed to remove that back button.
        
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
    
    //To automatically scroll down the table view whenever a new message appears. That way the user doesn't have to scroll down every time
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messageArray.count-1, section: 0)
            self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBody.text = messageArray[indexPath.row].messageBody     //Assigning the message as the message obtained from the model class
        cell.senderUsername.text = senderCut(email: messageArray[indexPath.row].sender) //Assigining the user label as the username received from the model class
        cell.senderUsername.textColor = UIColor.flatBlack()
        if messageArray[indexPath.row].sender == Auth.auth().currentUser?.email {       //this if else statement is to assign different colors and text alignment to different users and distinguish the messages between users
            cell.senderUsername.textAlignment = .right  //this is for the messages being composed by us
            cell.messageBody.textAlignment = .right
            cell.messageBody.textColor = UIColor.flatMint()
        } else {
            cell.senderUsername.textAlignment = .left   //this is for the messages being received from the other user
            cell.messageBody.textAlignment = .left
            cell.messageBody.textColor = UIColor.flatTeal()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {       //to declare the number of rows required in the table view to adequately fit messages
        return messageArray.count       
    }
    
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension      //this is to automatically adjust the height of the cells in order to display the entire message
        messageTableView.estimatedRowHeight = 120.0                     //defining an estimated row height in case needed
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {           //this function is called whenever the user clicks on the text field to compose a new message
        heightConstraint.constant = 308                                 //this is the necessary constraint to pull up the text field and leave just the right amount of space to house the keyboard underneath the text field 
        view.layoutIfNeeded()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {      //this function is called whenever user taps on the return button on the keyboard. in this case it is assigned to push down the keyboard to allow the user to read the chats
        textField.resignFirstResponder()                                //to hide the keyboard upon clicking the 'return' button
        heightConstraint.constant = 50                                  //redefining the constraint to send down the text field as the keyboard will now be hidden
        view.layoutIfNeeded()
        return true
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {                   //this function is called whenever the send button is clicked
        sendButton.isEnabled = false                                    //firstly, the send button needs to be disbaled to prevent the the user from sending the same message multiple times
        
        //Send the message to Firebase and save it in our database
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email, "MessageBody": messageTextfield.text!]  //declaring who was the sender and what message they sent and uploading this to the Firebase database using a dictionary
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            if error != nil {                                       
                SVProgressHUD.showError(withStatus: "Error")        //In the case there was an error in sending the message, an error HUD will be popped up to let the user know their message was not delivered
            } else {
                self.messageTextfield.isEnabled = true              //if the message was sent, firstly, the text field should be enabled 
                self.sendButton.isEnabled = true                    //the send button should also be enabled
                self.messageTextfield.text = ""                     //finally the text field should be reset to no characters
            }
        }
    }
    
    func retrieveMessages() {       //this function is needed to pull all previous messages the user had sent or received
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in      //using this closure to extract the messages and their respective sender names
            let snapshotValue = snapshot.value as! [String : String]    
            let text = snapshotValue["MessageBody"]!        //extract messages and storing them as 'text' to store them in the message.messageBody
            let sender = snapshotValue["Sender"]!           //extract sender names and storing them as 'sender' to store them message.sender
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
            self.scrollToBottom()
        }
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) { //this function is called whenever the user taps on the Log out button
        
        //Log out the user and send them back to WelcomeViewController
        do {
            try Auth.auth().signOut()       //to sign out the user
            SVProgressHUD.showSuccess(withStatus: "Log out successful")  //if it was successful, the user will get an HUD indicating they were successfully logged out
            navigationController?.popViewController(animated: true)     //this is to redirect the user to the screen they were on before entering the chat screen. So this could be the log in screen or the register screen
        } catch {
            SVProgressHUD.showError(withStatus: "Log out failed")       //else, display an HUD to indicate the user was not signed out
        }
    }
}
