//
//  LoginVC.swift
//  rootsTask
//
//  Created by Hatem on 20/04/2025.
//

import UIKit

class LoginVC: BaseVC {

    //MARK: - IBOutlets
    @IBOutlet weak var userTypeTextField: UITextField!
    @IBOutlet weak var typeValidationErrorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidationErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationErrorLabel: UILabel!
    @IBOutlet weak var languageButtonOutlet: UIButton!
    
    //MARK: - Properties
    let userTypes = ["None".localized, "Admin".localized, "User".localized]
    let pickerView = UIPickerView()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: - IBActions
    @IBAction func loginAction(_ sender: Any) {
        validateFields()
    }
    @IBAction func signUpAction(_ sender: Any) {
        self.navigateWithXib(to: SignUpVC.self)
    }
    @IBAction func changeLangAction(_ sender: Any) {
        changeLanguage()
    }
    
}

//MARK: - Configurations
extension LoginVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func setupView() {
        languageButtonOutlet.titleLabel?.text = currentLanguage
        pickerView.delegate = self
        pickerView.dataSource = self
        userTypeTextField.inputView = pickerView
        setupTextField()
    }
    func setupTextField() {
        emailTextField.delegate = self
        userTypeTextField.delegate = self
        passwordTextField.delegate = self
    }

    func validateFields() {
        var isValid = true

        if let email = emailTextField.text, !isValidEmail(email) {
            emailValidationErrorLabel.isHidden = false
            isValid = false
        } else {
            emailValidationErrorLabel.isHidden = true
        }

        if let userType = userTypeTextField.text, userType.isEmpty || userType == "None" {
            typeValidationErrorLabel.isHidden = false
            isValid = false
        } else {
            typeValidationErrorLabel.isHidden = true
        }

        if let password = passwordTextField.text, !isValidPassword(password) {
            passwordValidationErrorLabel.isHidden = false
            isValid = false
        } else {
            passwordValidationErrorLabel.isHidden = true
        }

       
        if isValid {
            self.navigateWithXibAsRoot(to: TabbarVC.self)
            UserDefaults.standard.setValue(true, forKey: "isLoggined")

            print("All inputs are valid")
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView, numberOfRowsInComponent component: Int
    ) -> Int {
        return userTypes.count
    }

    func pickerView(
        _ pickerView: UIPickerView, titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return userTypes[row]
    }

    func pickerView(
        _ pickerView: UIPickerView, didSelectRow row: Int,
        inComponent component: Int
    ) {
        userTypeTextField.text = userTypes[row]
        userTypeTextField.resignFirstResponder()
    }
}
//MARK: - UITextField Configurations

extension LoginVC: UITextFieldDelegate {
 
    func textFieldDidEndEditing(_ textField: UITextField) {
        let newText = textField.text ?? ""

        if textField == passwordTextField {
            passwordValidationErrorLabel.isHidden = isValidPassword(newText)
        }

        if textField == emailTextField {
            emailValidationErrorLabel.isHidden = isValidEmail(newText)
        }
        if textField == userTypeTextField {
            typeValidationErrorLabel.isHidden = !(newText.isEmpty || newText == "None")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            userTypeTextField.becomeFirstResponder()
        } else if textField == userTypeTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            validateFields()
            
            textField.resignFirstResponder()
        }
        return true
    }

}

import Foundation

extension Bundle {
    private static var localizedBundle: Bundle?

    // This function will set the language for the app
    static func setLanguage(_ language: String) {
        // Get the path to the specific language bundle
        let path = Bundle.main.bundlePath + "/\(language).lproj"
        if let languageBundle = Bundle(path: path) {
            self.localizedBundle = languageBundle
        } else {
            self.localizedBundle = Bundle.main // Fallback to the main bundle if not found
        }
    }

    // Override the localized method to return the correct resource path
    static func localizedPath(forResource name: String?, ofType ext: String?) -> String? {
        // If a localized bundle is set, return the localized resource path
        if let bundle = self.localizedBundle {
            return bundle.path(forResource: name, ofType: ext)
        }
        // Otherwise, fall back to the main bundle
        return Bundle.main.path(forResource: name, ofType: ext)
    }
}
