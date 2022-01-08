//
//  DatabaseManger.swift
//  Chat
//
//  Created by administrator on 05/01/2022.
//

import Foundation
import FirebaseDatabase

final class DatabaseManger{
    
    static let shared = DatabaseManger()
    private let database = Database.database().reference()

}

extension DatabaseManger{
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
           var safeEmail = email.replacingOccurrences(of: ".", with: "-")
           safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")

           database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
               guard snapshot.value as? String != nil else{
                   completion(false)
                   return
               }
               completion(true)
           })
           return
       }
    
    public func insertUser(with user: ChatEverUser, completion: @escaping (Bool) -> Void){
        database.child(user.safeEmail).setValue([
            
            "firstName" : user.firstName,
            "lastName" : user.lastName
            
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
              print("failed write to database")
                completion(false)
                return
            }
            completion(true)
            
        })
        
    }
    
    
}

struct ChatEverUser{
    let firstName:String
    let lastName:String
    let email:String
    
    var safeEmail : String{
    var safeEmail = email.replacingOccurrences(of: ".", with: "-")
    safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            return safeEmail
    
}
    var profilePictureFileName: String {
        return "\(safeEmail)_profile_picture.png"
    }

}
