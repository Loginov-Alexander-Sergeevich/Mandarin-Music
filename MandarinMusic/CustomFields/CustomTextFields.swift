//
//  CustomTextFields.swift
//  MandarinMusic
//
//  Created by Александр Александров on 18.12.2021.
//

import Foundation
import UIKit
import SnapKit

public final class CustomTextFields: UIView {
    
    // Название текстового поля
    private var nameTextFieldLabel: UILabel = {
        let label = UILabel()
        label.font.withSize(20)
        label.textColor = .black
        return label
    }()
    
    // Настраиваемое текстовое поле
    public lazy var customTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.contentMode = .scaleAspectFit
        textField.delegate = self
        return textField
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        addSabviews(views: [nameTextFieldLabel, customTextField])
        configurationConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Имя для текстового поля
    var labelText: String = "" {
        didSet {
            nameTextFieldLabel.text = labelText
        }
    }
    
    /// Заполнитель текстового поля
    var placeholderText: String = "" {
        didSet {
            customTextField.placeholder = placeholderText
        }
    }
    
    /// Тип отоброжаемой клавиатуры
    var keyboardType: UIKeyboardType = .default {
        didSet {
            customTextField.keyboardType = keyboardType
        }
    }
    
    /// Текст введенный в текстовое поле
    var textFieldText: String {
        return customTextField.text ?? ""
    }
    
    var isSecureText: Bool = true {
        didSet {
            customTextField.isSecureTextEntry = isSecureText
        }
    }
    
    /// Установи ограничения
    private func configurationConstraints() {
        
        nameTextFieldLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview()
        }
        
        customTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(nameTextFieldLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension CustomTextFields: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Скрытие текстового поля
        customTextField.resignFirstResponder()
        return true
    }
}
