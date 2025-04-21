//
//  BaseVC.swift
//  rootsTask
//
//  Created by Hatem on 20/04/2025.
//

import UIKit

class BaseVC: UIViewController {

    //MARK: - Properties
    lazy var isLoggined: Bool = {
        if UserDefaults.standard.bool(forKey: "isLoggined") == true {
            isLoggined = true
        } else {
            isLoggined = false
        }
        return isLoggined
    }()
    
    lazy var currentLanguage: String = {
        if UserDefaults.standard.string(forKey: "appLanguage") == "en" {
            currentLanguage = "EN"
        } else {
            currentLanguage = "AR"
        }
        return currentLanguage
    }()
  
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
  

}

//Validation
extension BaseVC {

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(
            with: password)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    func isValidName(_ name: String) -> Bool {
        let regex = "^[a-zA-Z ]+$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(
            with: name)
    }
    func isValidPhone(_ phone: String) -> Bool {
        let digitsOnly = phone.filter { $0.isNumber }
        return digitsOnly.count >= 10
    }
}


extension BaseVC {
    @objc
    func changeLanguage() {
        let current =
            UserDefaults.standard.string(forKey: "appLanguage") ?? "en"
        let next = (current == "en") ? "ar" : "en"
        UserDefaults.standard.set(next, forKey: "appLanguage")
        openAppSettings {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                exit(0)
            }
        }
    }
    
    func openAppSettings(completion: @escaping () -> Void) {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsURL, options: [:]) { _ in
                    completion()
                }
            } else {
                UIApplication.shared.openURL(settingsURL)
                completion()
            }
        }
    }
}

