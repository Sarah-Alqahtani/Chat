//
//  ProfileVC.swift
//  Chat
//
//  Created by administrator on 06/01/2022.
//

import UIKit
import FirebaseAuth


class ProfileVC: UIViewController {

    @IBAction func logout(_ sender: UIButton) {
        
        do {
                    try FirebaseAuth.Auth.auth().signOut()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SigninVC") as! SigninVC
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: false)
                } catch {
                    print("Error Log Out User: \(error.localizedDescription)")
                }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

   

}
