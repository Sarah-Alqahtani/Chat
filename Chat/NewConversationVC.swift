//
//  NewConversationVC.swift
//  Chat
//
//  Created by administrator on 06/01/2022.
//

import UIKit
import SwiftUI
import JGProgressHUD

class NewConversationVC: UIViewController {

    private let spinner = JGProgressHUD()
    
    private let SearchBar : UISearchBar = {
      
        let searchBar = UISearchBar()
        searchBar.placeholder="Search for user.."
        return searchBar
    }()
    private let tabelView: UITableView = {
    
        let tabel = UITableView()
        tabel.isHidden = true
        tabel.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        
        return tabel
        
    }()
    
    private let noResultLabel : UILabel = {
      let label = UILabel()
        label.isHidden=true
        label.text = "No Results"
        label.textAlignment = .center
        label.textColor = .blue
        label.font = .systemFont(ofSize: 21,weight: .regular)
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        SearchBar.delegate=self
        navigationController?.navigationBar.topItem?.titleView = SearchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismesSself))
       
        SearchBar.becomeFirstResponder()
    }
    
    @objc func dismesSself(){
        dismiss(animated: true,completion: nil)
    }


}
extension NewConversationVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
