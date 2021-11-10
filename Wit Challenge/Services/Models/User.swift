//
//  User.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 06/11/21.
//

import Foundation

struct User: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
    let name: String?
    let bio: String?
    let publicRepos: Int?
    let publicGists: Int?
    let followers: Int?
    let following: Int?
}
