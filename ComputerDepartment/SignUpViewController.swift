//
//  SignUpViewController.swift
//  ComputerDepartment
//
//  Created by 오재우 on 6/17/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardObservers() // 키보드 옵저버 설정
        setupTapGesture() // 화면 탭 제스처 설정
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
    }
    
    deinit {
        // 옵저버 해제
        removeKeyboardObservers()
    }
    
    // 회원가입 버튼이 눌렸을 때 호출되는 함수
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "입력 오류", message: "이메일을 입력해주세요")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "입력 오류", message: "비밀번호를 입력해주세요")
            return
        }
        
        guard let confirmPassword = confirmPasswordTextField.text, confirmPassword == password else {
            showAlert(title: "입력 오류", message: "비밀번호가 일치하지 않습니다")
            return
        }
        
        // Firebase Auth를 이용해 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showAlert(title: "회원가입 오류", message: error.localizedDescription)
            } else {
                // Firestore에 사용자 정보 저장
                guard let user = authResult?.user else { return }
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData([
                    "email": email
                    // 필요한 다른 사용자 정보를 추가
                ]) { error in
                    if let error = error {
                        self?.showAlert(title: "데이터베이스 오류", message: error.localizedDescription)
                    } else {
                        self?.showAlert(title: "회원가입 성공", message: "회원가입이 완료되었습니다") {
                            DispatchQueue.main.async {
                                self?.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 이메일 유효성 검사 함수
    private func validateEmail(_ email: String) -> Bool {
        let emailPattern = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    // 비밀번호 유효성 검사 함수
    private func validatePassword(_ password: String) -> Bool {
        let pwPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+=-]).{8,16}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", pwPattern)
        return passwordPredicate.evaluate(with: password)
    }
    
    // 알림창을 표시하는 함수
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // 키보드 이벤트 감지 옵저버 설정
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드 이벤트 감지 옵저버 해제
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드가 나타날 때 호출되는 메서드
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardFrame.height
            }
        }
    }
    
    // 키보드가 사라질 때 호출되는 메서드
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // 빈 화면을 탭하면 키보드가 사라지도록 제스처를 설정하는 메서드
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // 키보드를 숨기는 메서드
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate 메서드 추가
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

/*
 // MARK: - Navigation

 // 스토리보드를 이용한 네비게이션에서 준비할 일이 있을 때 호출되는 함수
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // 새 뷰 컨트롤러를 가져오고 전달할 데이터를 설정합니다.
 }
 */
