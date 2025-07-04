import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseAppCheck

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // 앱이 시작될 때 호출되는 함수
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Firebase 초기화
        FirebaseApp.configure()
        
        // 윈도우 인스턴스 생성
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 사용자가 로그인했는지 여부 확인
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        // 초기 뷰 컨트롤러 설정
        if isLoggedIn {
            showMainTabBarController()
        } else {
            showLoginViewController()
        }

        return true
    }

    // 메인 탭 바 컨트롤러를 표시하는 함수
    private func showMainTabBarController() {
        let tabBarController = UITabBarControllerViewController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    // 로그인 뷰 컨트롤러를 표시하는 함수
    private func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

    // 새로운 씬 세션이 연결될 때 호출되는 함수
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // 사용자가 씬 세션을 삭제할 때 호출되는 함수
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
