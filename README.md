# FlashChat

<img src="https://github.com/adbht/FlashChat/blob/master/Screenshots%20and%20Video/Video.mov" width="900" />

<img src="https://github.com/adbht/FlashChat/blob/master/Screenshots%20and%20Video/1.%20Launch%20Screen.JPG" width="288" /> <img src="https://github.com/adbht/FlashChat/blob/master/Screenshots%20and%20Video/2.%20Welcome%20Screen.JPG" width="288" /> <img src="https://github.com/adbht/FlashChat/blob/master/Screenshots%20and%20Video/3.%20Register%20Screen.JPG" width="288" /> 

<img src="https://github.com/adbht/FlashChat/blob/master/Screenshots%20and%20Video/4.%20Typing%20User%20Credentials.JPG" width="288" />                                                                                                                   <img src="https://github.com/adbht/FlashChat/blob/master/Screenshots%20and%20Video/5.%20Chat%20Screen.JPG" width="288" />       <img src="https://github.com/adbht/FlashChat/blob/master/Screenshots%20and%20Video/6.%20Logging%20Out.JPG" width="288" /> 

## About
FlashChat is a live messaging application for iOS using Swift and Google’s Firebase database service for backend support on securely saving user accounts and their personal chats. So reinstallation or any future updates will result in no user data loss. To keep a clear structure on all the files, this application was designed and developed by implementing the Model View Controller (MVC) design pattern. 

## CocoaPods
This application was developed with the following 5 CocoaPods: 
   - Firebase
   - Firebase/Auth
   - Firebase/Database
   - SVProgressHUD
   - ChameleonFramework

## MVC Design Pattern
   - Model
     - [Message.swift](https://github.com/adbht/FlashChat/blob/master/FlashChat/Model/Message.swift)
   - View
     - [Main.storyboard](https://github.com/adbht/FlashChat/blob/master/FlashChat/View/Main.storyboard)
     - [LaunchScreen.storyboard](https://github.com/adbht/FlashChat/blob/master/FlashChat/View/LaunchScreen.storyboard)
     - [Custom Cell](https://github.com/adbht/FlashChat/tree/master/FlashChat/View/Custom%20Cell)
       - [CustomMessageCell.swift](https://github.com/adbht/FlashChat/blob/master/FlashChat/View/Custom%20Cell/CustomMessageCell.swift)
       - [MessageCell.xib](https://github.com/adbht/FlashChat/blob/master/FlashChat/View/Custom%20Cell/MessageCell.xib)
   - Controller
     - [AppDelegate.swift](https://github.com/adbht/FlashChat/blob/master/FlashChat/Controller/AppDelegate.swift)
     - [ChatViewController.swift](https://github.com/adbht/FlashChat/blob/master/FlashChat/Controller/ChatViewController.swift)
     - [LogInViewController.swift](https://github.com/adbht/FlashChat/blob/master/FlashChat/Controller/LogInViewController.swift)
     - [RegisterViewController.swift](https://github.com/adbht/FlashChat/blob/master/FlashChat/Controller/RegisterViewController.swift)
     - [WelcomeViewController.swift](https://github.com/adbht/FlashChat/blob/master/FlashChat/Controller/WelcomeViewController.swift)
