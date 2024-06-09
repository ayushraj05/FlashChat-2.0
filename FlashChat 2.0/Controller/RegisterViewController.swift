//
//  RegisterViewController.swift
//  FlashChat 2.0
//
//  Created by Ayush Rajpal on 09/06/24.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func RegisterButtonGotPressed(_ sender: UIButton) {
        if let email = emailTextField.text ,let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)
                } else{
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
                
            }
        }
    }
    


}
