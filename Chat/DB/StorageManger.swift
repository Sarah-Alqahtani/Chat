//
//  StorageManger.swift
//  Chat
//
//  Created by administrator on 08/01/2022.
//

import Foundation
import FirebaseStorage
import SwiftUI

final class StorageManger{
    
    static let shared = StorageManger()
    private let storage = Storage.storage().reference()
    
    public typealias UPloadPictureCompletion = (Result<String,Error>) -> Void
    
    public func uploadProfilePicture(with data: Data, fileName:String, completion: @escaping UPloadPictureCompletion ){
        storage.child("image/\(fileName)").putData(data, metadata: nil, completion: {metadata, error in
            
            guard error == nil else {
                
                //failed
                print("Failed to upload data to firebase for Image\(error?.localizedDescription)")
                completion(.failure(StorageErorr.faildToUpload))
                return
            }
            
            self.storage.child("image/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("Failed tp get download url")
                    completion(.failure(StorageErorr.faildToGetDownloadUrl))
               return
                }
                let urlString = url.absoluteString
                print("download url returned:\(urlString)")
                completion(.success(urlString))
                
            })
            
        })
        
    }
    func downloadImage(imageView:UIImageView,url: URL){
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
            
        } ).resume()
    }
    public enum StorageErorr : Error {
        
        case faildToUpload
        case faildToGetDownloadUrl
  
    }
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
           let reference = storage.child(path)

           reference.downloadURL(completion: { url, error in
               guard let url = url, error == nil else {
                   completion(.failure(StorageErorr.faildToGetDownloadUrl))
                   return
               }

               completion(.success(url))
           })
       }
   }
