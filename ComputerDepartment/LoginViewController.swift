import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

// LoginViewController 클래스: 로그인 화면을 관리하는 뷰 컨트롤러
class LoginViewController: UIViewController, UITextFieldDelegate {
    // 이메일 입력 필드
    @IBOutlet weak var emailTextField: UITextField!
    // 비밀번호 입력 필드
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 키보드 이벤트를 감지하는 옵저버 설정
        setupKeyboardObservers()
        setupTapGesture()
        
        // 텍스트 필드 델리게이트 설정
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // 비밀번호 필드를 보안 모드로 설정
        passwordTextField.isSecureTextEntry = true
    }
    
    deinit {
        // 옵저버 해제
        removeKeyboardObservers()
    }
    
    // 로그인 버튼 클릭 시 호출되는 메서드
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // 이메일과 비밀번호 입력 값 검증
        guard let id = emailTextField.text, !id.isEmpty else {
            showAlert(title: "입력오류", message: "아이디를 입력해주세요")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "입력오류", message: "비밀번호를 입력해주세요")
            return
        }
        
        // Firebase Auth를 사용하여 로그인 시도
        Auth.auth().signIn(withEmail: id, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showAlert(title: "로그인 오류", message: error.localizedDescription)
            } else {
                UserDefaults.standard.set(true, forKey: "isLoggedIn") // 로그인 상태 저장
                self?.navigateToTabBarController()
            }
        }
    }
    
    // 회원가입 버튼 클릭 시 호출되는 메서드
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // Segue를 수행하여 회원가입 화면으로 이동
        performSegue(withIdentifier: "showSignUP", sender: self)
    }
    
    // 경고창을 표시하는 메서드
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
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
    
    // 키보드가 나타날 때 호출
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardSize.cgRectValue
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardFrame.height
            }
        }
    }
    
    // 키보드가 사라질 때 호출
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // 빈 화면을 탭하면 키보드가 사라지도록 제스처 설정
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
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            loginButtonTapped(UIButton()) // 엔터 키를 누르면 로그인 시도
        }
        return true
    }
    
    // 로그인 성공 시 탭바 컨트롤러로 전환하는 메서드
    private func navigateToTabBarController() {
        let tabBarController = UITabBarControllerViewController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
}
