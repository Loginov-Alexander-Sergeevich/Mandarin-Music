//
//  Extension + String.swift
//  MandarinMusic
//
//  Created by Александр Александров on 18.12.2021.
//

import Foundation

extension String {
    // Тип
    enum TextFieldType {
        case fierstName
        case lastName
        case age
        case numberPhone
        case email
        case password
    }
    
    // Регулярное выражение
    enum Regex: String {
        case name = "[a-zA-Zа-яА-Я]{2,}"
        case email = "[a-zA-Z0-9._-]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
        case numberPhone = "[0-9]{11,}"
        case age = "^[0-3]?[0-9].[0-3]?[0-9].(?:[0-9]{2})?[0-9]{2}$"
    }
    
    /// Проверь данные на валидность
    /// - Parameter isValidType: Тип проверяемых данных
    /// - Returns: Результат проверки
    func isValidTextField(isValidType: TextFieldType) -> Bool {
        
        // Формат проверки
        let format = "SELF MATCHES %@"
        
        var regex = ""
        
        switch isValidType {
        case .fierstName:
            regex = Regex.name.rawValue
        case .lastName:
            regex = Regex.name.rawValue
        case .age:
            regex = Regex.age.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        case .numberPhone:
            regex = Regex.numberPhone.rawValue
        }
        
        print("isValid = \(NSPredicate(format: format, regex).evaluate(with: self))")
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
