//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by Aditya Bhatia on 2018-07-24.
//  Copyright (c) 2018 adbht. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    @IBOutlet var messageBackground: UIView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
