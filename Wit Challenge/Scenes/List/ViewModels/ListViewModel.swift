//
//  ListViewModel.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 06/11/21.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func displayUsers(with users: [User])
    func displayUser(with user: User)
    func displayErros(error: Error)
}

class ListViewModel {
    private let service = GitHubService()
        
    weak var delegate: ListViewModelDelegate?
    
    func loadUsers() {
        service.fetchUsers { result in
            
            switch result {
            case .success(let users):
                self.delegate?.displayUsers(with: users)
                
            case .failure(let error):
                self.delegate?.displayErros(error: error)
            }
        }
    }
    
    func loadUser(with userName: String ) {
        service.fetchUser(with: userName) { result in
            
            switch result {
            case .success(let user):
                self.delegate?.displayUser(with: user)
                
            case .failure(let error):
                self.delegate?.displayErros(error: error)
            }
        }
    }
}
