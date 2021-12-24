//
//  LoginViewController.swift
//  MandarinMusic
//
//  Created by Александр Александров on 18.12.2021.
//

import Foundation
import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "LOGIN"
        label.font.withSize(40)
        return label
    }()
    
    private let emailTextField: CustomTextFields = {
        let customTextFields = CustomTextFields()
        customTextFields.placeholderText = "E-mail"
        return customTextFields
    }()
    
    private let passwordTextField: CustomTextFields = {
        let customTextFields = CustomTextFields()
        customTextFields.isSecureText = true
        customTextFields.placeholderText = "Password"
        return customTextFields
    }()
    
    /// Кнопка "Войти"
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    /// Кнопка "Регистрация"
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurationView()
        configurationCostraints()
    }
    
    /// Конфигурация view
    private func configurationView() {
        view.addSabviews(views: [loginLabel, emailTextField, passwordTextField, signInButton, signUpButton])
    }
    
    /// Установи ограничения
    private func configurationCostraints() {
        
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emailTextField.snp.centerX)
            make.centerY.equalToSuperview().offset(-100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(15)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.centerX).offset(-5)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.leading.equalTo(passwordTextField.snp.centerX).offset(5)
            
        }
    }
}

extension LoginViewController {
    @objc func signInButtonAction() {
        let albumVC = AlbumViewController()
        albumVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(albumVC, animated: true)
       
        //present(albumVC, animated: true)
    }
    
    @objc func signUpButtonAction() {
        let registrationVC = RegistrationViewController()
        present(registrationVC, animated: true)
    }
}
