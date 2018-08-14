//
//  RegisterViewController.swift
//  Flash Chat
//
//  Created by Aditya Bhatia on 2018-07-24.
//  Copyright (c) 2018 adbht. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    //For users to input their new email addresses and password to register for a Firebase database
    @IBOutlet var emailTextfield: UITextField!          //Textfield where user inputs their email address
    @IBOutlet var passwordTextfield: UITextField!       //Textfield where user inputs their password
    
    @IBAction func registerPressed(_ sender: AnyObject) {   //This function is executed when the user clicks on the Register button
        SVProgressHUD.show()        //To display the loading animated wheel so the user knows that the application is trying to register the user in the database
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) {    //This closure is used to check if the the user's inputted credentials satisfy Firebase's email and password criterias.
            (user, error) in
            if error != nil {   
                SVProgressHUD.showError(withStatus: "Registration failed")  //This is to display HUD to let user know that registration failed. This can be due to reasons such as email address only has an account or no  network connectivity.
            } else {
                SVProgressHUD.dismiss()     //If registration was successful, firstly the loading wheel needs to be stopped to let the uses know that the registration was completed
                self.performSegue(withIdentifier: "goToChat", sender: self)     //Secondly, the user should be redirected to the chat screen where they can finally begin chatting
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
