//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ChatViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages:[Message] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        load_data()
        
        
        
    }
    func load_data(){
        
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{ QuerySnapshot, error in
            self.messages = []
            if error != nil{
                print(error as Any)
            }else{
                
                if let query = QuerySnapshot?.documents{
                    for document in query{
                        if let sender = document[K.FStore.senderField] as? String, let message = document[K.FStore.bodyField] as? String{
                            let new_message = Message(sender: sender, body: message)
                            self.messages.append(new_message)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexpath = IndexPath(row: self.messages.count-1,
                                    section: 0)
                                self.tableView.scrollToRow(at: indexpath, at: .top, animated: true)
                                
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        
        if let message = messageTextfield.text, let sender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: sender,
                K.FStore.bodyField: message,
                K.FStore.dateField: Date().timeIntervalSince1970
                ]) { error in
                if error != nil{
                    print(error ?? "")
                }
                    DispatchQueue.main.sync {
                        self.messageTextfield.text = ""
                    }
            }
        }
        
        
        
        
    }
    


    @IBAction func logout_pressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sender = messages[indexPath.row].sender
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        if sender == Auth.auth().currentUser?.email{
            cell.right_image.isHidden = false
            cell.left_image.isHidden = true
            cell.message_buble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }else{
            cell.right_image.isHidden = true
            cell.left_image.isHidden = false
            cell.message_buble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
    
    
}
