import UIKit

// UITabBarControllerViewController 클래스: 탭바 컨트롤러를 관리하는 뷰 컨트롤러
class UITabBarControllerViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 각 탭에 해당하는 뷰 컨트롤러 생성
        let equipmentRentalController = EquipmentRentalController()
        let rentalStatusController = RentalStatusController()
        let homeController = HomeController()
        let locationController = LocationController()
        let roomRentalController = RoomRentalController()
        
        // 각 뷰 컨트롤러를 내비게이션 컨트롤러에 포함
        let equipmentRentalNavController = UINavigationController(rootViewController: equipmentRentalController)
        let rentalStatusNavController = UINavigationController(rootViewController: rentalStatusController)
        let homeNavController = UINavigationController(rootViewController: homeController)
        let locationNavController = UINavigationController(rootViewController: locationController)
        let roomRentalNavController = UINavigationController(rootViewController: roomRentalController)
        
        // 각 내비게이션 컨트롤러에 탭바 아이템 설정
        equipmentRentalNavController.tabBarItem = UITabBarItem(title: "기자재 대여", image: UIImage(systemName: "laptopcomputer.and.ipad"), tag: 1)
        rentalStatusNavController.tabBarItem = UITabBarItem(title: "대여 현황", image: UIImage(systemName: "calendar.badge.checkmark"), tag: 2)
        homeNavController.tabBarItem = UITabBarItem(title: "공지사항", image: UIImage(systemName: "house.lodge"), tag: 0)
        locationNavController.tabBarItem = UITabBarItem(title: "위치", image: UIImage(systemName: "location.viewfinder"), tag: 3)
        roomRentalNavController.tabBarItem = UITabBarItem(title: "강의실 대여", image: UIImage(systemName: "person.3.fill"), tag: 5)

        // 탭바 컨트롤러의 뷰 컨트롤러 배열에 내비게이션 컨트롤러 추가
        viewControllers = [
            homeNavController,
            equipmentRentalNavController,
            roomRentalNavController,
            rentalStatusNavController,
            locationNavController,
        ]
        
        // 초기 선택된 탭 인덱스 설정
        selectedIndex = 0
        
        // 탭바 설정
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white // 탭바 배경색을 흰색으로 설정
        tabBar.tintColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1) // 탭바 아이템 선택 색상 설정
        tabBar.unselectedItemTintColor = UIColor(red: 172/255, green: 172/255, blue: 172/255, alpha: 1) // 선택되지 않은 탭바 아이템 색상 설정
    }
}
