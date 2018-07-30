# FlashChat

## Final Product
<img src="https://github.com/adbht/FlashChat/blob/master/FlashChat%20Cropped%20Video.mov" width="600" />

## About
FlashChat is a live messaging application for iOS using Swift and Google’s Firebase database service for backend support on securely saving user accounts and their personal chats. So reinstallation or any future updates will result in no user data loss. To keep a clear structure on all the files, this application was designed and developed by implementing the Model View Controller (MVC) design pattern. 

## Cocoapods
This application was developed with the following 5 Cocoapods: 
   - Firebase
   - Firebase/Auth
   - Firebase/Database
   - SVProgressHUD
   - ChameleonFramework

## MVC Design Pattern
   - Model
     - Message.swift
   - View
     - Main.storyboard
     - LaunchScreen.storyboard
     - CustomCell
       - CustomMessageCell.swift
       - MessageCell.xib
   - Controller
     - AppDelegate.swift
     - ChatViewController.swift
     - LogInViewController.swift
     - RegisterViewController.swift
     - WelcomeViewController.swift
