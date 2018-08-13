//
//  LogInViewController.swift
//  Flash Chat
//
//  Created by Aditya Bhatia on 2018-07-24.
//  Copyright (c) 2018 adbht. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    //For users to input their email addresses and password to log in to their Firebase database
    @IBOutlet var emailTextfield: UITextField!      //Textfield where user inputs their email address
    @IBOutlet var passwordTextfield: UITextField!   //Textfield where user inputs their password
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logInPressed(_ sender: AnyObject) {  //This function is executed when the user clicks on the Log In button
        SVProgressHUD.show()                            //To display the loading animated wheel so the user knows that the application is trying to log in to the user's database
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in //This closure is used to check if the the user's inputted credentials matched with Firebase's existing user accounts
            if error != nil {
                SVProgressHUD.showError(withStatus: "Incorrect email address or password. Please try again.")   //Display an error HUD if log in was unsuccessful. This can happen due reasons such as incorrect user credentials or no network connectivity.
            } else {
                SVProgressHUD.dismiss() //If the log in was successful, stop displaying the loading wheel as the application has accessed user's database
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
}  
