//
//  ViewController.swift
//  MessagingAppIOS
//
//  Created by Wajeeh Ul Hassan on 02/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var AppNamelabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 44)
        label.textAlignment = .center
        return label
    }()
    
    lazy var loginNavigationBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(self.navigateToLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var registerNavigationBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(self.navigateToRegister), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setUpUI()
        self.titleLabelAnimation()
    }
    
    func titleLabelAnimation() {
        self.AppNamelabel.text = ""
        var charIndex = 0.0
        let titleText = "ChatApp"
        
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.AppNamelabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    func setUpUI() {
        self.view.addSubview(self.AppNamelabel)
        self.view.addSubview(self.loginNavigationBtn)
        self.view.addSubview(self.registerNavigationBtn)
        
        self.AppNamelabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.AppNamelabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        self.loginNavigationBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        self.loginNavigationBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.loginNavigationBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.loginNavigationBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.registerNavigationBtn.bottomAnchor.constraint(equalTo: self.loginNavigationBtn.topAnchor, constant: -8).isActive = true
        self.registerNavigationBtn.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.registerNavigationBtn.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.registerNavigationBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }

    @objc
    func navigateToLogin() {
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc
    func navigateToRegister() {
        let loginVC = RegisterViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

}

