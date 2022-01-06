//
//  Regster.swift
//  Chat
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class Regster: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
    //var PickerVc:UIImagePickerController?

    @IBOutlet weak var FirstName: UITextField!
    
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var EmailRgster: UITextField!
    
    @IBOutlet weak var NewPassword: UITextField!
    
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Account"
        
        image.isUserInteractionEnabled = true
                let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
                image.addGestureRecognizer(gesture)
        
        
        
    }
    @objc func didTapChangeProfilePic() {
        presentPhotoActionSheet()

        }


    @IBAction func Rgsterbtn(_ sender: UIButton) {
        
        guard let fName = FirstName.text, let lName = LastName.text, let eAddress = EmailRgster.text , let nPass = NewPassword.text, !fName.isEmpty, !lName.isEmpty , !eAddress.isEmpty, !nPass.isEmpty else {
                         alertEmpty()
                         return
                     }
        
        spinner.show(in: view)
             // Firebase Login
            DatabaseManger.shared.userExists(with: eAddress, completion: { [weak self] exists in
                 guard let strongSelf = self else{
                     return
                 }
                
                DispatchQueue.main.async {
                    strongSelf.spinner.dismiss()
                }
                
                 guard !exists else{
                  // user already exists
                     strongSelf.alertEmpty(message: "Account already exists")
                     return
                 }
                 Auth.auth().createUser(withEmail: eAddress, password: nPass, completion: { authResult, error in
                     
                     guard authResult != nil, error == nil else{
                         print("Error Creating User")
                         return
                     }
                     DatabaseManger.shared.insertUser(with: ChatEverUser(firstName: fName, lastName: lName, email: eAddress))
                     strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                 })
             })
                }
    
    
    
    func alertEmpty(message: String = "Text Fields must be not empty"){
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alert, animated: true)
    }

}

extension Regster:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
         let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
         actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
             self?.presentCamera()
         }))
         actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
             self?.presentPhotoPicker()
         }))
         
         present(actionSheet, animated: true)
     }
     func presentCamera() {
         let vc = UIImagePickerController()
         vc.sourceType = .camera
         vc.delegate = self
         vc.allowsEditing = true
         present(vc, animated: true)
     }
     func presentPhotoPicker() {
         let vc = UIImagePickerController()
         vc.sourceType = .photoLibrary
         vc.delegate = self
         vc.allowsEditing = true
         present(vc, animated: true)
     }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         // take a photo or select a photo
         
         // action sheet - take photo or choose photo
         picker.dismiss(animated: true, completion: nil)
         print(info)
         
         guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
             return
         }
         
         self.image.image = selectedImage
         
     }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
     }
     
 }
