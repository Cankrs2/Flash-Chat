//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        
        let title_text = K.appName
        var char_index = 0.0
        for letter in title_text{
            Timer.scheduledTimer(withTimeInterval: 0.1*char_index, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            char_index += 1
            
        }
    }
}


