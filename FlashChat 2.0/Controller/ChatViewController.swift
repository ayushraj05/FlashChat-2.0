//
//  ChatViewController.swift
//  FlashChat 2.0
//
//  Created by Ayush Rajpal on 09/06/24.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        TableView.dataSource = self
//        TableView.delegate = self
        super.viewDidLoad()
        TableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        navigationItem.title = K.appName
        navigationItem.hidesBackButton = true
        
        loadMessages()
    }
    
    func loadMessages(){
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error{
                print(e)
            } else{
                if let snapShotDocument = querySnapshot?.documents {
                    
                    for doc in snapShotDocument{
                        let data = doc.data()
                        
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.TableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func SendMessageGotPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text ,let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender, 
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { error in
                if let e = error{
                    print(e)
                } else{
                    print("data saved to db ")
                }
            }
        }
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.MessageLable.text = messages[indexPath.row].body
        return cell
    }
    
}
//
//extension ChatViewController: UITableViewDelegate{
//    
//}
