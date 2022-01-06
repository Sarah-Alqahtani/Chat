//
//  chatViewController.swift
//  Chat
//
//  Created by administrator on 06/01/2022.
//

import UIKit
import MessageKit


struct Message:MessageType{
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    
}

struct Sender:SenderType{
    
    var PhotoUrl: String
    var senderId: String
    var displayName: String
    
}

class chatViewController: MessagesViewController {
    
    private var messages = [Message]()
    private let selfSender = Sender(PhotoUrl: "",
                                    senderId: "1",
                                    displayName: "Sarah Alqahtani")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .red
        
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind:  .text("Hii world ")))
        
        messages.append(Message(sender: selfSender,
                                messageId: "1",
                                sentDate: Date(),
                                kind:  .text("Hii world hello ")))
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
    }
    

}
extension chatViewController: MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate{
    func currentSender() -> SenderType {
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
    
    
    
}
