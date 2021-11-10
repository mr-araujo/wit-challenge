//
//  ListView.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 06/11/21.
//

import UIKit

protocol ClickCellDelegate {
    func segueDetailViewController(with userName: String)
}

final class ListView: UIView {
    
    private let listViewCellIdentifier = "ListViewCellIdentifier"
    private var users: [User] = []
    private var viewModel: ListViewModel!
    var delegate: ClickCellDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListViewCell.self, forCellReuseIdentifier: self.listViewCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        self.configureSubviews()
        self.setSubviewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    func configureSubviews() {
        self.backgroundColor = .white
        self.addSubview(self.tableView)
    }
    
    func setSubviewsConstraints() {
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(with viewModel: ListViewModel) {
        self.viewModel = viewModel
        self.viewModel.delegate = self
        loadUsers()
    }
    
    func loadUser(with userName: String) {
        self.viewModel.loadUser(with: userName)
    }
    
    func loadUsers() {
        self.viewModel.loadUsers()
    }
}

extension ListView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.listViewCellIdentifier, for: indexPath) as! ListViewCell
        
        let user = users[indexPath.row]
        cell.userLabel.text = user.login
        
        if let urlPhoto = URL(string: user.avatarUrl) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let data = try Data(contentsOf: urlPhoto)
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        cell.userImageView.image = image
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        return cell
    }
}

extension ListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        delegate?.segueDetailViewController(with: user.login)
    }
}

extension ListView: ListViewModelDelegate {
    func displayUser(with user: User) {
        DispatchQueue.main.async {
            self.users.removeAll()
            self.users.append(user)
            self.tableView.reloadData()
        }
    }
    
    func displayUsers(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    func displayErros(error: Error) {
        print(error)
    }
}
