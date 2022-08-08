//
//  ChatTableViewCell.swift
//  MessagingAppIOS
//
//  Created by Wajeeh Ul Hassan on 04/08/2022.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    static let reuseId = "\(ChatTableViewCell.self)"
    
    lazy var userEmail: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "wajeeh@gmail.com"
        label.tintColor = .systemBlue
        label.layer.cornerRadius = 25.0
        label.font = UIFont.systemFont(ofSize: 12.0)

        return label
    }()
    
    lazy var messageText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Message Text"

        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "01:22"
        label.tintColor = .systemBlue
        label.layer.cornerRadius = 25.0
        label.font = UIFont.systemFont(ofSize: 10.0)

        return label
    }()
    
    lazy var bubbleBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5.0
        
        return view
    }()
    
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var isIncomming: Bool! {
        didSet {
            if isIncomming {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            } else {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpUI() {
        
        addSubview(self.userEmail)
        addSubview(self.bubbleBackgroundView)
        addSubview(self.messageText)
        addSubview(self.timeLabel)


        self.messageText.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        self.messageText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        self.messageText.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        
        self.userEmail.topAnchor.constraint(equalTo: self.messageText.topAnchor, constant: -32).isActive = true
        self.userEmail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        self.userEmail.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
        self.bubbleBackgroundView.topAnchor.constraint(equalTo: self.messageText.topAnchor, constant: -16).isActive = true
        self.bubbleBackgroundView.leadingAnchor.constraint(equalTo: self.messageText.leadingAnchor, constant: -16).isActive = true
        self.bubbleBackgroundView.bottomAnchor.constraint(equalTo: self.messageText.bottomAnchor, constant: 16).isActive = true
        self.bubbleBackgroundView.trailingAnchor.constraint(equalTo: self.messageText.trailingAnchor, constant: 16).isActive = true
        
        
        self.timeLabel.topAnchor.constraint(equalTo: self.bubbleBackgroundView.bottomAnchor, constant: 2).isActive = true
        self.timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        self.timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        leadingConstraint = self.messageText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = false
        
        trailingConstraint = self.messageText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        trailingConstraint.isActive = true
        
        
        
    }
}
