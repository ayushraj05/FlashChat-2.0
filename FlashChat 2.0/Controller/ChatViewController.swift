//
//  ChatViewController.swift
//  FlashChat 2.0
//
//  Created by Ayush Rajpal on 09/06/24.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = K.appName
        navigationItem.hidesBackButton = true
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
