//
//  SigninVC.swift
//  Chat
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth

class SigninVC: UIViewController {
    
    @IBOutlet weak var EmailSignin: UITextField!
    
    @IBOutlet weak var PasswordSignIn: UITextField!
    
    @IBAction func facebookbtn(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))

    }
    
    @IBAction func SignInbtn(_ sender: Any) {
        EmailSignin.resignFirstResponder()
        PasswordSignIn.resignFirstResponder()
        
        guard let email = EmailSignin.text, let password = PasswordSignIn.text, !email.isEmpty, !password.isEmpty else {
                  alertLogInError()
                  return
              }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, error in
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email \(email)")
                return
            }
            let user = result.user
            print("logged in user: \(user)")
        })
    }
    func alertLogInError() {
        let alert = UIAlertController(title: "Error", message: "Please, enter all required fields to log in!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Regster") as! Regster
            self.navigationController?.pushViewController(vc, animated: false)
        }

  

}
