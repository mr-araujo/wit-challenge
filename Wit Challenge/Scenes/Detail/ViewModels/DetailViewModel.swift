//
//  DetailViewModel.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 09/11/21.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func displayUser(with user: User)
    func displayErros(error: Error)
}

class DetailViewModel {
    private let service = GitHubService()
        
    weak var delegate: DetailViewModelDelegate?
    
    private var userName: String
    
    init(username: String) {
        self.userName = username
    }
     
    func loadUser() {
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
