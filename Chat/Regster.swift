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
    
    
    @IBOutlet weak var imageUiView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Account"
        
        imageUiView.isUserInteractionEnabled = true
                let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
                imageUiView.addGestureRecognizer(gesture)
        
        
        
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
                     let chatUser = ChatEverUser(firstName: fName, lastName: lName, email: eAddress)
                     DatabaseManger.shared.insertUser(with: chatUser,completion: { success in
                         if success {
                             //upload image
                             guard let image = strongSelf.imageUiView.image,
                                    let data = image.pngData() else {
                                        return
                                    }
                             let fileName = chatUser.profilePictureFileName
                             StorageManger.shared.uploadProfilePicture(with: data, fileName: fileName, completion: { result in
                                 switch result{
                                 case.success(let downloadUrl):
                                     UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                     print(downloadUrl)
                                 case.failure(let error):
                                     print("Storage manger error\(error)")
                                 }
                                 
                             })
                                    
                         }
                     })
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
         
         self.imageUiView.image = selectedImage
         
     }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
     }
     
 }
