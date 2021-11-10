//
//  ListViewCell.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 06/11/21.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    lazy var userImageView: UIImageView = {
        let avatar = UIImageView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 30
        avatar.layer.masksToBounds = true
        avatar.layer.borderWidth = 2
        avatar.layer.borderColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha: 1).cgColor
        avatar.setContentCompressionResistancePriority(.required, for: .horizontal)
        return avatar
    }()
    
    lazy var userLabel: UILabel = {
        let ownerName = UILabel()
        ownerName.translatesAutoresizingMaskIntoConstraints = false
        ownerName.textColor = .darkGray
        ownerName.font = UIFont.boldSystemFont(ofSize: 14)
        return ownerName
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.configureSubview()
        self.setSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubview() {
        self.addSubview(self.userImageView)
        self.addSubview(self.userLabel)
    }
      
    private func setSubviewConstraints() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 60),
            userImageView.heightAnchor.constraint(equalToConstant: 60),
            
            userLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 20),
            userLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
