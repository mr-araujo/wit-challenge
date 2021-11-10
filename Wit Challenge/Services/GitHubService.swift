//
//  GitHubService.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 06/11/21.
//

import Foundation

/*
 Json Contract
 {
   "login": "mr-araujo",
   "id": 14891276,
   "avatar_url": "https://avatars.githubusercontent.com/u/14891276?v=4",
   "name": "Murillo R. Araujo",
   "bio": "iOS Developer",
   "public_repos": 19,
   "public_gists": 0,
   "followers": 4,
   "following": 3,
 }
*/


protocol GitHubServiceProtocol {
    func fetchUsers(completion: @escaping ( Result <[User], Error> ) -> Void)
    func fetchUser(with userName: String, completion: @escaping ( Result <User, Error> ) -> Void)
}

enum ErrosAPI: Error  {
    case emptyData
    case emptyURL
    case genericError(message: String)
}

struct GitHubService: GitHubServiceProtocol {
    
    private let apiURL = "https://api.github.com/users"
    
    func fetchUsers(completion: @escaping ( Result <[User], Error> ) -> Void) {
        guard let api = URL(string: apiURL) else {
            completion(.failure(ErrosAPI.emptyURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { (data, response, error) in
            
            if let error = error {
                print(error)
                completion(.failure(ErrosAPI.genericError(message: error.localizedDescription)))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(ErrosAPI.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode([User].self, from: jsonData)
                
                completion(.success(data))
            } catch let error {
                completion(.failure(ErrosAPI.genericError(message: error.localizedDescription)))
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchUser(with userName: String, completion: @escaping ( Result <User, Error> ) -> Void) {
        
        let userURL = "\(apiURL)/\(userName.removingSpaces())"
        
        guard let api = URL(string: userURL) else {
            completion(.failure(ErrosAPI.emptyURL))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { (data, response, error) in
            
            if let error = error {
                print(error)
                completion(.failure(ErrosAPI.genericError(message: error.localizedDescription)))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(ErrosAPI.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(User.self, from: jsonData)
                
                completion(.success(data))
            } catch let error {
                completion(.failure(ErrosAPI.genericError(message: error.localizedDescription)))
            }
        }
        task.resume()
    }
}
