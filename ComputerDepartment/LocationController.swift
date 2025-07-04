import UIKit
import MapKit

// LocationController 클래스: 위치 정보를 표시하는 뷰 컨트롤러
class LocationController: UIViewController {
    
    // 스크롤 뷰와 컨텐츠 뷰
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // 맵 뷰와 라벨
    let mapView1 = MKMapView()
    let mapView2 = MKMapView()
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let locationLabel1 = UILabel()
    let locationLabel2 = UILabel()
    let boxView1 = UIView()
    let boxView2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "위치"
        
        // UI 설정 메서드 호출
        setupViews()
        setupConstraints()
        setupLocations()
    }
    
    // UI 뷰 설정
    private func setupViews() {
        // ScrollView 및 ContentView 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // Box View 1 설정
        boxView1.layer.borderWidth = 1
        boxView1.layer.borderColor = UIColor.lightGray.cgColor
        boxView1.layer.cornerRadius = 8
        boxView1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(boxView1)
        
        // Title Label 1 설정
        titleLabel1.text = "- 실습 사무실 -"
        titleLabel1.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel1.textAlignment = .center
        titleLabel1.translatesAutoresizingMaskIntoConstraints = false
        boxView1.addSubview(titleLabel1)
        
        // Map View 1 설정
        mapView1.translatesAutoresizingMaskIntoConstraints = false
        boxView1.addSubview(mapView1)
        
        // Location Label 1 설정
        locationLabel1.text = "위치: 서울 성북구 삼선교로16길 116 공학관 A동"
        locationLabel1.translatesAutoresizingMaskIntoConstraints = false
        boxView1.addSubview(locationLabel1)
        
        // Box View 2 설정
        boxView2.layer.borderWidth = 1
        boxView2.layer.borderColor = UIColor.lightGray.cgColor
        boxView2.layer.cornerRadius = 8
        boxView2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(boxView2)
        
        // Title Label 2 설정
        titleLabel2.text = "- 행정 사무실 -"
        titleLabel2.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel2.textAlignment = .center
        titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        boxView2.addSubview(titleLabel2)
        
        // Map View 2 설정
        mapView2.translatesAutoresizingMaskIntoConstraints = false
        boxView2.addSubview(mapView2)
        
        // Location Label 2 설정
        locationLabel2.text = "위치: 서울 성북구 삼선교로16길 116 지선관"
        locationLabel2.translatesAutoresizingMaskIntoConstraints = false
        boxView2.addSubview(locationLabel2)
    }
    
    // 제약 조건 설정
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView 제약 조건
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView 제약 조건
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Box View 1 제약 조건
            boxView1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            boxView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            boxView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Title Label 1 제약 조건
            titleLabel1.topAnchor.constraint(equalTo: boxView1.topAnchor, constant: 10),
            titleLabel1.leadingAnchor.constraint(equalTo: boxView1.leadingAnchor, constant: 10),
            titleLabel1.trailingAnchor.constraint(equalTo: boxView1.trailingAnchor, constant: -10),
            
            // Map View 1 제약 조건
            mapView1.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor, constant: 10),
            mapView1.leadingAnchor.constraint(equalTo: boxView1.leadingAnchor, constant: 10),
            mapView1.trailingAnchor.constraint(equalTo: boxView1.trailingAnchor, constant: -10),
            mapView1.heightAnchor.constraint(equalToConstant: 200),
            
            // Location Label 1 제약 조건
            locationLabel1.topAnchor.constraint(equalTo: mapView1.bottomAnchor, constant: 10),
            locationLabel1.leadingAnchor.constraint(equalTo: boxView1.leadingAnchor, constant: 10),
            locationLabel1.trailingAnchor.constraint(equalTo: boxView1.trailingAnchor, constant: -10),
            locationLabel1.bottomAnchor.constraint(equalTo: boxView1.bottomAnchor, constant: -10),
            
            // Box View 2 제약 조건
            boxView2.topAnchor.constraint(equalTo: boxView1.bottomAnchor, constant: 20),
            boxView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            boxView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            boxView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // Title Label 2 제약 조건
            titleLabel2.topAnchor.constraint(equalTo: boxView2.topAnchor, constant: 10),
            titleLabel2.leadingAnchor.constraint(equalTo: boxView2.leadingAnchor, constant: 10),
            titleLabel2.trailingAnchor.constraint(equalTo: boxView2.trailingAnchor, constant: -10),
            
            // Map View 2 제약 조건
            mapView2.topAnchor.constraint(equalTo: titleLabel2.bottomAnchor, constant: 10),
            mapView2.leadingAnchor.constraint(equalTo: boxView2.leadingAnchor, constant: 10),
            mapView2.trailingAnchor.constraint(equalTo: boxView2.trailingAnchor, constant: -10),
            mapView2.heightAnchor.constraint(equalToConstant: 200),
            
            // Location Label 2 제약 조건
            locationLabel2.topAnchor.constraint(equalTo: mapView2.bottomAnchor, constant: 10),
            locationLabel2.leadingAnchor.constraint(equalTo: boxView2.leadingAnchor, constant: 10),
            locationLabel2.trailingAnchor.constraint(equalTo: boxView2.trailingAnchor, constant: -10),
            locationLabel2.bottomAnchor.constraint(equalTo: boxView2.bottomAnchor, constant: -10),
        ])
    }
    
    // 위치 설정
    private func setupLocations() {
        // 각 위치에 대한 좌표 설정
        let location1 = CLLocationCoordinate2D(latitude: 37.581826, longitude: 127.009860)
        let location2 = CLLocationCoordinate2D(latitude: 37.582034, longitude: 127.009868)
        
        // 각 맵 뷰에 위치 설정
        setMapLocation(mapView: mapView1, coordinate: location1, title: "서울 성북구 삼선교로16길 116 공학관 A동")
        setMapLocation(mapView: mapView2, coordinate: location2, title: "서울 성북구 삼선교로16길 116 지선관")
    }
    
    // 맵 뷰에 위치를 설정하는 메서드
    private func setMapLocation(mapView: MKMapView, coordinate: CLLocationCoordinate2D, title: String) {
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0012, longitudeDelta: 0.0012))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}
