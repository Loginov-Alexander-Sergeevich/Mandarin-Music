//
//  RegistrationViewController.swift
//  MandarinMusic
//
//  Created by Александр Александров on 18.12.2021.
//

import Foundation
import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    let storage = UserDefault.shared
    
    let registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font.withSize(30)
        return label
    }()
    
    let firstNameTextField: CustomTextFields = {
        let customTextField = CustomTextFields()
        customTextField.labelText = "First name"
        customTextField.placeholderText = "Enter a name"
        return customTextField
    }()
    
    let lastNameTextField: CustomTextFields = {
        let customTextField = CustomTextFields()
        customTextField.labelText = "Last name"
        customTextField.placeholderText = "Enter your last name"
        return customTextField
    }()
    
    let ageTextField: CustomTextFields = {
        let textField = CustomTextFields()
        textField.labelText = "Дата рождения"
        textField.placeholderText = "Выбери дату рождения"
        
        // UIDatePicker Для выбора даты рождения
        let datePicker = UIDatePicker()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = .init(identifier: "ru_RU")
        datePicker.preferredDatePickerStyle = .wheels
        
        // Покажи UIDatePicker при выборе поля "Дата рождения"
        textField.customTextField.inputView = datePicker
        
        // Установи размер панели для кнопок "Отмена" и "Выбрать"
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        
        // Кнопка "Отмена"
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelBtnClick))
        
        // Кнопка "Выбрать"
        let doneButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: self, action: #selector(doneBtnClick))
        
        // Помести кнопки на панель
        toolbar.setItems([cancelButton, doneButton], animated: true)
        
        textField.customTextField.inputAccessoryView = toolbar
        
        return textField
    }()
    
    let numberPhoneTextField: CustomTextFields = {
        let customTextField = CustomTextFields()
        customTextField.labelText = "Number phone"
        customTextField.placeholderText = "Enter your phone number"
        return customTextField
    }()
    
    let emailTextField: CustomTextFields = {
        let customTextField = CustomTextFields()
        customTextField.labelText = "E-Mail"
        customTextField.placeholderText = "Enter E-Mail"
        return customTextField
    }()
    
    let passwordTextField: CustomTextFields = {
        let customTextField = CustomTextFields()
        customTextField.labelText = "Password"
        customTextField.placeholderText = "Enter the password"
        return customTextField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        return button
    }()
    
    let scrolView: UIScrollView = {
        let scrilView = UIScrollView()
        return scrilView
    }()
    
    /// UIAlertController
    var myAlert: UIAlertController = {
        let alert = UIAlertController(title: "Ошибка", message: "Заполни все поля", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        return alert
    }()
    
    var registrationStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        configurationConstraints()
    }
    
    private func setView() {
        view.backgroundColor = .white
        view.addSabviews(views: [registrationLabel, scrolView, signUpButton])
        
        registrationStackView = UIStackView(arrangedSubviews: [firstNameTextField,
                                                               lastNameTextField,
                                                               ageTextField,
                                                               numberPhoneTextField,
                                                               emailTextField,
                                                               passwordTextField],
                                            axis: .vertical,
                                            spacing: 10,
                                            distribution: .fillEqually,
                                            aligment: .fill)
        scrolView.addSubview(registrationStackView)
    }

    private func configurationConstraints () {
        
        let cgButton: CGSize = CGSize(width: 190, height: 40)
        
        registrationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        scrolView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(registrationLabel.snp.bottom).offset(20)
            make.bottom.equalTo(signUpButton.snp.top).offset(-20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.size.equalTo(cgButton)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        
        registrationStackView.snp.makeConstraints { make in
            make.height.equalTo(500)
            make.leading.trailing.equalTo(view).inset(10)
            make.top.equalTo(scrolView.snp.top)
            make.bottom.equalTo(scrolView.snp.bottom)
        }
    }
    
    
    /// Экшен для кнопки "Регистрация"
    @objc func registrationButtonAction() {
        
        // Если в полях отсутствует текст
        if firstNameTextField.textFieldText.isEmpty
            && lastNameTextField.textFieldText.isEmpty
            && numberPhoneTextField.textFieldText.isEmpty
            && emailTextField.textFieldText.isEmpty
            && passwordTextField.textFieldText.isEmpty
        {
            // Покажи ошибку
            present(myAlert, animated: true)
        } else {
            // Если текст присутствует проверить его на валидность
            checkValidText()
        }
    }
    
    /// Экшен для кнопки "Отмена" в UIDatePicker
    @objc func cancelBtnClick() {
        ageTextField.customTextField.resignFirstResponder()
    }
    // Экшен для кнопки "Выбрать" в UIDatePicker
    @objc func doneBtnClick() {
        // Если выбрано поле ввода даты рождения покажи UIDatePicker
        if let datePicker = ageTextField.customTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .init(identifier: "ru-RU")
            dateFormatter.dateStyle = .short
            // Запиши выбранную дату в поле ageTextField
            ageTextField.customTextField.text = dateFormatter.string(from: datePicker.date)
        }
        // Убери с экрана UIDatePicker
        ageTextField.customTextField.resignFirstResponder()
    }
    
    
    /// Метод для проверки валидности текста
    private func checkValidText() {
        let loginVC = LoginViewController()
        
        let firstNameText = firstNameTextField.textFieldText
        let lastNameText = lastNameTextField.textFieldText
        let numberPhoneText = numberPhoneTextField.textFieldText
        let emailText = emailTextField.textFieldText
        let passwordText = passwordTextField.textFieldText
        
        // Если текст не валидный
        if !firstNameText.isValidTextField(isValidType: .fierstName) {
            // Покажи ошибку
            myAlert.message = "Поле 'Имя' не верно! \n Минимум 2 символа, только буквы"
        } else if  !lastNameText.isValidTextField(isValidType: .lastName) {
            myAlert.message = "Поле 'Фамилия' не верно! \n Минимум 2 символа, только буквы"
        } else if  !numberPhoneText.isValidTextField(isValidType: .numberPhone) {
            myAlert.message = "Поле 'Номер телефона' не верно! \n Минимум 11 символа, x-xxx-xxx-xx-xx"
        } else if  !emailText.isValidTextField(isValidType: .email) {
            myAlert.message = "Поле 'Email' не верно! \n x@x.xx"
        } else if  !passwordText.isValidTextField(isValidType: .password) {
            myAlert.message = "Поле 'Пароль' не верно! \n Должен состоять и букв верхнего и нижнего регистра, минимум 1 цифры и минимум из 6 символов"
        } else {
            // Если текст валидный сохрани "email" и "password" для входа в систему
            storage.set(key: .email, value: emailText)
            storage.set(key: .password, value: passwordText)
            // Перейди на экран авторизации LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true)
        }
        present(myAlert, animated: true)
    }
}
