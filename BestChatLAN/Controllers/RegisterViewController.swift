//
//  RegisterViewController.swift
//  BestChatLAN
//
//  Created by Isaac Sanchez on 24/03/22.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            createNewUser(email: email, password: password)
        }
    }
    
    func createNewUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "RegisterToChat", sender: self)
            }
    
        }
    }
    
}
