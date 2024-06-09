//
//  WelcomeViewController.swift
//  FlashChat 2.0
//
//  Created by Ayush Rajpal on 09/06/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var FastChatLable: UILabel!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let titleLable = FastChatLable.text!
            FastChatLable.text = ""
            var charIndex = 0.0
            
            for letter in titleLable{
                Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { timer in
                    self.FastChatLable.text?.append(letter)
                }
                charIndex += 1
            }
            
        }

}
