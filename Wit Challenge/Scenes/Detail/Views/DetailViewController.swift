//
//  DetailViewController.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 06/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel!
    
    lazy var avatarImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 65
        avatar.layer.masksToBounds = true
        avatar.layer.borderWidth = 4
        avatar.layer.borderColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha: 1).cgColor
        return avatar
    }()
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 25)
        name.textColor = .darkGray
        return name
    }()
    
    lazy var bioLabel: UILabel = {
        let bio = UILabel()
        bio.translatesAutoresizingMaskIntoConstraints = false
        bio.font = UIFont.boldSystemFont(ofSize: 17)
        return bio
    }()
    
    lazy var repoBadge: BadgeView = {
        let repo = BadgeView()
        repo.translatesAutoresizingMaskIntoConstraints = false
        return repo
    }()
    
    lazy var projectBadge: BadgeView = {
        let project = BadgeView()
        project.translatesAutoresizingMaskIntoConstraints = false
        return project
    }()
    
    lazy var followerBadge: BadgeView = {
        let followers = BadgeView()
        followers.translatesAutoresizingMaskIntoConstraints = false
        return followers
    }()
    
    lazy var followingBadge: BadgeView = {
        let following = BadgeView()
        following.translatesAutoresizingMaskIntoConstraints = false
        return following
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 1
        stack.distribution = .equalCentering
        return stack
    }()
    
    lazy var octocatImageView: UIImageView = {
        let octocat = UIImageView()
        octocat.translatesAutoresizingMaskIntoConstraints = false
        octocat.image = UIImage(named: "Octocat")
        return octocat
    }()
    
    init(viewModel: DetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.loadUser()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubViews()
    }
    
    func configureSubViews() {
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(bioLabel)
        view.addSubview(stackView)
        view.addSubview(octocatImageView)
        
        stackView.addArrangedSubview(repoBadge)
        stackView.addArrangedSubview(projectBadge)
        stackView.addArrangedSubview(followerBadge)
        stackView.addArrangedSubview(followingBadge)
        
        setUserImageViewConstraints()
        setNameLabelConstraints()
        setBioLabelConstraints()
        setStackViewConstraints()
        setOctocatImageViewConstraints()
    }
    
    func setUserImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            self.avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 130),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 130),
        ])
    }
    
    func setNameLabelConstraints() {
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 25),
            self.nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setBioLabelConstraints() {
        NSLayoutConstraint.activate([
            self.bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            self.bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 30),
            self.stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350),
            self.stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func setOctocatImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.octocatImageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            self.octocatImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            self.octocatImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            self.octocatImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func displayUser(with user: User) {
        
        if let urlPhoto = URL(string: user.avatarUrl) {
            DispatchQueue.global(qos: .background).async {
                do {
                    let data = try Data(contentsOf: urlPhoto)
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.avatarImageView.image = image
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        
        DispatchQueue.main.async {
            
            if let name = user.name {
                self.nameLabel.text = name
            }
            
            if let bio = user.bio {
                self.bioLabel.text = bio
            }
            
            if let repo = user.publicRepos {
                self.repoBadge.configure(with: BadgeViewModel(icon: UIImage(systemName: "folder")!, number: repo, text: "repositories"))
            }
            
            if let projects = user.publicGists {
                self.projectBadge.configure(with: BadgeViewModel(icon: UIImage(systemName: "hammer")!, number: projects, text: "projects"))
            }
            
            if let followers = user.followers {
                self.followerBadge.configure(with: BadgeViewModel(icon: UIImage(systemName: "heart")!, number: followers, text: "followers"))
            }
            
            if let following = user.following {
                self.followingBadge.configure(with: BadgeViewModel(icon: UIImage(systemName: "checkmark.seal")!, number: following, text: "following"))
            }
        }
    }
    
    func displayErros(error: Error) {
        print(error)
    }
}
