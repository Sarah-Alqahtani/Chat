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
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler:{[weak self] _ in
            guard let strongSelf = self else {
                return
            }
      
            do {
                        try FirebaseAuth.Auth.auth().signOut()
                let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: "SigninVC") as! SigninVC
                        let nav = UINavigationController(rootViewController: vc)
                        nav.modalPresentationStyle = .fullScreen
             
            strongSelf.present(nav, animated: true)
                
                    } catch {
                        print("Error Log Out User: \(error.localizedDescription)")
                    }
    }))
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(actionSheet , animated: true)
   
}

        
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//    func alertCancel(){
//        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
//        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler:{[weak self] _ in
//            guard let strongSelf = self else {
//                return
//            }
//
//        }))
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(actionSheet , animated: true)
//
//    }
//


}
