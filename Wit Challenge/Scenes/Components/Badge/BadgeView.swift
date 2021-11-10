//
//  BadgeView.swift
//  Wit Challenge
//
//  Created by Murillo R. Araújo on 09/11/21.
//

import UIKit

class BadgeView: UIView {
    
    lazy var iconImageView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = .black
        return icon
    }()
    
    lazy var numberLabel: UILabel = {
        let number = UILabel()
        number.translatesAutoresizingMaskIntoConstraints = false
        number.font = UIFont.boldSystemFont(ofSize: 12)
        number.textColor = .black
        return number
    }()
    
    lazy var textLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 8)
        text.textColor = .gray
        return text
    }()
    
    private var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        self.configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        backgroundColor = .white
        addSubview(stackView)
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(numberLabel)
        stackView.addArrangedSubview(textLabel)
        
        setIconImageViewConstraints()
    }
    
    func setIconImageViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25)
        ])
    }
    
    func configure(with viewModel: BadgeViewModel) {
        iconImageView.image = viewModel.icon
        numberLabel.text = String(viewModel.number)
        textLabel.text = viewModel.text
    }
}
