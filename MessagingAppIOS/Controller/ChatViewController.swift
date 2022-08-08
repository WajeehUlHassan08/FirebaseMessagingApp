//
//  ChatViewController.swift
//  MessagingAppIOS
//
//  Created by Wajeeh Ul Hassan on 02/08/2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    lazy var chatTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.reuseId)
        return table
    }()
    
//    let sendMessageTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "Type Message Here..."
//        textField.borderStyle = .roundedRect
//        textField.backgroundColor = UIColor(white: 0, alpha: 0.1)
//        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        return textField
//    }()
    
    let sendMessageTextField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textView.font = .systemFont(ofSize: 16)
        return textView
    }()
    
    let sendMessageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor.systemBlue
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.tintColor = .white
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "ChatApp"
        
        setUpUI()
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(signoutUser))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        loadMessages()
    }
    
    private func setUpUI() {
        self.view.addSubview(self.chatTableView)
        
        self.chatTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.chatTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.chatTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5.0

        stackView.addArrangedSubview(self.sendMessageTextField)
        stackView.addArrangedSubview(self.sendMessageBtn)
        
        self.view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.chatTableView.bottomAnchor, constant: 8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        
        self.sendMessageTextField.widthAnchor.constraint(equalTo: sendMessageTextField.widthAnchor, multiplier: 1).isActive = true
        self.sendMessageBtn.widthAnchor.constraint(equalTo: self.sendMessageBtn.widthAnchor, multiplier: 1).isActive = true
    }
    
    func loadMessages() {
        
        db.collection("messages").order(by: "sent_at").addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let snapDocs = querySnapshot?.documents {
                for doc in snapDocs {
                    let data = doc.data()
                    
                    if let messageSender = data["sender"] as? String, let messageBody = data["body"] as? String, let messageTime = data["sent_at"] as? String {
            
                        let myDate = NSDate(timeIntervalSince1970: TimeInterval(Double(messageTime)!))
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"

                        let actualDate = dateFormatter.date(from: dateFormatter.string(from: myDate as Date))
                        dateFormatter.dateFormat = "HH:mm"
                        
                        let dateToShow = dateFormatter.string(from: actualDate!)
                    
                        let newMessage = Message(sender: messageSender, body: messageBody, sent_at: dateToShow)
                        self.messages.append(newMessage)

                        DispatchQueue.main.async {
                            self.chatTableView.reloadData()
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    @objc
    func sendMessage() {
        
        if let messageBody = sendMessageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            
            if messageBody.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return
            }
            
            db.collection("messages").addDocument(data: [
                "sender": messageSender,
                "body": messageBody,
                "sent_at": String(Date().timeIntervalSince1970)
            ]) { (error) in
                if let error = error {
                    print(error)
                }
            }
            
            self.sendMessageTextField.text = ""
        }
    }

    @objc
    func signoutUser() {
        do {
            try Auth.auth().signOut()
//            self.messages = []
            navigationController?.popToRootViewController(animated: true)
        } catch let error {
            print(error)
        }
    }

}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.reuseId, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }


        
        if messages.count > 0 {
            if let currentUserFirebase = Auth.auth().currentUser?.email {
                if self.messages[indexPath.row].sender == currentUserFirebase {
                    cell.isIncomming = true
                    cell.bubbleBackgroundView.backgroundColor = UIColor(red: 0.3412, green: 0.4667, blue: 0.8392, alpha: 1.0)
                    cell.messageText.textColor = .white
                    cell.userEmail.isHidden = true
                    cell.timeLabel.textAlignment = .right
                    
                    
                } else {
                    cell.isIncomming = false
                    cell.bubbleBackgroundView.backgroundColor = UIColor(red: 0.8745, green: 0.8706, blue: 0.9176, alpha: 1.0)
                    cell.messageText.textColor = .black
                    cell.userEmail.isHidden = false
                    cell.timeLabel.textAlignment = .left
                }
            }
            
            cell.messageText.text = messages[indexPath.row].body
            cell.userEmail.text = messages[indexPath.row].sender
            cell.timeLabel.text = messages[indexPath.row].sent_at
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
}
