//
//  ListViewController.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 06/11/21.
//

import UIKit

class ListViewController: UIViewController {
    
    private lazy var listView: ListView = {
        let listView = ListView()
        listView.delegate = self
        listView.configure(with: ListViewModel())
        return listView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = "Type a GitHub user name"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "GitHub Users"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ListViewController: ClickCellDelegate {
    func segueDetailViewController(with userName: String) {
        let vc = DetailViewController(viewModel: DetailViewModel(username: userName))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListViewController: UISearchBarDelegate, UISearchControllerDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       
        if let userName = searchBar.text, !userName.isEmpty {
            listView.loadUser(with: userName)
            return
        }
        
        listView.loadUsers()
    }
}
