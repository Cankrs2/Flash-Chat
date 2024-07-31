//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Can Akarsu on 11.03.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var right_image: UIImageView!
    @IBOutlet weak var left_image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var message_buble: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        message_buble.layer.cornerRadius = message_buble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
