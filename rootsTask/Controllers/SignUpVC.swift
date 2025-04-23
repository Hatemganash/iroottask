//
//  SignUpVC.swift
//  rootsTask
//
//  Created by Hatem on 20/04/2025.
//

import UIKit

class SignUpVC: BaseVC {

    //MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var fullNameValidationErrorLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameValidationErrorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidationErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationErrorLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var phoneValidationErrorLabel: UILabel!
    //MARK: - Properties

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: - IBActions
    @IBAction func signUpAction(_ sender: Any) {
        validateFields()
    }
    @IBAction func loginAction(_ sender: Any) {
        self.navigateWithXibAsRoot(to: LoginVC.self)
    }

}

//MARK: - Configurations
extension SignUpVC {

    func setupView() {
        setupTextField()
        setupKeyboardObservers()
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let bottomInset = keyboardFrame.height + 20
        scrollView.contentInset.bottom = bottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset

        if let activeField = view.currentFirstResponder() as? UIView {
            let fieldFrame = activeField.convert(activeField.bounds, to: scrollView)
            scrollView.scrollRectToVisible(fieldFrame, animated: true)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }


    func setupTextField() {
        fullNameTextField.delegate = self
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
    }

    func validateFields() {
        var isValid = true

        if !isValidName(fullNameTextField.text ?? "") {
            fullNameValidationErrorLabel.isHidden = false
            isValid = false
        } else {
            fullNameValidationErrorLabel.isHidden = true
        }

        if let username = userNameTextField.text, username.count < 6 {
            userNameValidationErrorLabel.isHidden = false
            isValid = false
        } else {
            userNameValidationErrorLabel.isHidden = true
        }

        if !isValidEmail(emailTextField.text ?? "") {
            emailValidationErrorLabel.isHidden = false
            isValid = false
        } else {
            emailValidationErrorLabel.isHidden = true
        }

        if !isValidPassword(passwordTextField.text ?? "") {
            passwordValidationErrorLabel.isHidden = false
            isValid = false
        } else {
            passwordValidationErrorLabel.isHidden = true
        }

        if !isValidPhone(phoneTextField.text ?? "") {
            phoneValidationErrorLabel.isHidden = false
            isValid = false
        } else {
            phoneValidationErrorLabel.isHidden = true
        }

        if isValid {
            self.navigateWithXibAsRoot(to: TabbarVC.self)
            UserDefaults.standard.setValue(true, forKey: "isLoggined")
        }
    }

}

//MARK: - UITextField Configurations
extension SignUpVC: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        let newText = textField.text ?? ""

        if textField == fullNameTextField {
            fullNameValidationErrorLabel.isHidden = isValidName(newText)
        }
        if textField == userNameTextField {
            userNameValidationErrorLabel.isHidden = newText.count >= 6
        }
        if textField == passwordTextField {
            passwordValidationErrorLabel.isHidden = isValidPassword(newText)
        }

        if textField == emailTextField {
            emailValidationErrorLabel.isHidden = isValidEmail(newText)
        }
        if textField == phoneTextField {
            phoneValidationErrorLabel.isHidden = isValidPhone(newText)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == fullNameTextField {
            userNameTextField.becomeFirstResponder()
        } else if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            phoneTextField.becomeFirstResponder()
        } else if textField == phoneTextField {
            validateFields()
            textField.resignFirstResponder()
        }

        return true
    }

}
