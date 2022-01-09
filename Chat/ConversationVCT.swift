//
//  ConversationVCT.swift
//  Chat
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
import SwiftUI

class ConversationVCT: ViewController {

    
    @IBOutlet weak var UiTabelView: UITableView!
    private let spinner = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))
        
       /* do{
                    try Auth.auth().signOut()
                }catch{
                    print(error.localizedDescription)
                }
*/
        
        
    }
    
    @objc private func didTapComposeButton(){
        let vc = NewConversationVC()
        let navVc = UINavigationController(rootViewController: vc)
        present(navVc , animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                   validateAuth()
        UiTabelView.delegate = self
        UiTabelView.dataSource = self
        }
    private let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.text = "no Conversations!"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private func validateAuth(){
            if Auth.auth().currentUser == nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SigninVC") as! SigninVC
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                self.present(navVC, animated: false)
                       }
                   }
}

extension ConversationVCT:UITableViewDataSource,UITableViewDelegate{
    
  
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 1
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text="Hello World!!!!!"
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath , animated: true)
         let vc = chatViewController()
         vc.navigationItem.largeTitleDisplayMode = .never
         navigationController?.pushViewController(vc, animated: true)
    }


}
