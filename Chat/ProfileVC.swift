//
//  ProfileVC.swift
//  Chat
//
//  Created by administrator on 06/01/2022.
//

import UIKit
import FirebaseAuth
import SDWebImage


class ProfileVC: UIViewController {
    


    @IBOutlet weak var imageUI: UIImageView!
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        
        
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
        imageUI.layer.borderColor = UIColor.white.cgColor
        imageUI.layer.borderWidth = 3
        imageUI.layer.masksToBounds = true
        imageUI.layer.cornerRadius = imageUI.frame.size.width/2


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
                    return
                }
                
        let emailCorrector = DatabaseManger.safeEmail(email: email)
                let filename = emailCorrector + "_profile_picture.png"
                let path = "image/"+filename
                StorageManger.shared.downloadURL (for:path, completion: { result in
                    switch result {
                    case .success(let url):
                        self.imageUI.sd_setImage(with: url, completed: nil)
                    case .failure(let error):
                        print("Download Url Failed: \(error)")
                    }
                })

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
