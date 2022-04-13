//
//  LoginViewController.swift
//  BestChatLAN
//
//  Created by Isaac Sanchez on 24/03/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            logInUser(email: email, password: password)
        }
    }
    
    func logInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let safeError = error {
                print(safeError.localizedDescription)
            } else {
                print(Auth.auth().currentUser!)
                strongSelf.performSegue(withIdentifier: "LoginToChat", sender: self)
            }
        }
    }
    
}
