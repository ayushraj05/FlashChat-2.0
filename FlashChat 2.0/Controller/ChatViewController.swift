//
//  ChatViewController.swift
//  FlashChat 2.0
//
//  Created by Ayush Rajpal on 09/06/24.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = [
        Message(sender: "a@b.com", body: "Hey there!"),
        Message(sender: "1@2.com", body: "yah!! 1@2 here"),
        Message(sender: "a@b.com", body: "ohh! i'm a@b")
    ]
    
    override func viewDidLoad() {
        TableView.dataSource = self
//        TableView.delegate = self
        super.viewDidLoad()
        navigationItem.title = K.appName
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func SendMessageGotPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func LogOutGotPressed(_ sender: UIBarButtonItem) {

        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    

}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = messages[indexPath.row].body
        return cell
    }
    
}
//
//extension ChatViewController: UITableViewDelegate{
//    
//}
