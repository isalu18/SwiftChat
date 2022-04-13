//
//  ChatViewController.swift
//  BestChatLAN
//
//  Created by Isaac Sanchez on 24/03/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    var messages: [Message] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        title = "🚀 BestChatLAN 🚀"
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection("messages").addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            
            if let e = error {
                print("Unable to retrieve data from firestore: \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let sender = data["sender"] as? String, let body = data["body"] as? String {
                            let newMessage = Message(sender: sender, body: body)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }

    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody]) { (error) in
                    if let e = error {
                        print("There was an error saving data to firestore: \(e)")
                    } else {
                        print("Data saved succcessfully")
                    }
                }
        }
        
        messageTextField.text = ""
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        logOutCurrentUser()
    }
    
    func logOutCurrentUser() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        
        cell.label.text = messages[indexPath.row].body
        
        return cell
    }
}
