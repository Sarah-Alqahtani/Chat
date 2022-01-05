//
//  Regster.swift
//  Chat
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth

class Regster: UIViewController {
    
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


    @IBAction func Rgsterbtn(_ sender: Any) {
        
        FirstName.resignFirstResponder()
        LastName.resignFirstResponder()
        EmailRgster.resignFirstResponder()
        NewPassword.resignFirstResponder()
        
        guard let firstName = FirstName.text, let lastName = LastName.text, let email = EmailRgster.text, let password = NewPassword.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
                   alertLogInError()
        
            
            return
    }
        guard let password = NewPassword.text, password.count >= 6  else {
                            alretPasswordError()
                            return
                        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { authResult , error  in
            guard let result = authResult, error == nil else {
                print("Error creating user")
                return
            }
            let user = result.user
            print("Created User: \(user)")
        })    }
    
    
    
    func alertLogInError() {
           let alert = UIAlertController(title: "Error", message: "Please, enter all required fields to create a new account!", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
           present(alert, animated: true)
       }
       
       func alretPasswordError() {
           let alert = UIAlertController(title: "Error", message: "Password must be 6 characters at least.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
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
