import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // 테이블 뷰 선언
    let tableView = UITableView()
    // 공지사항 배열 선언
    var notices: [Notice] = [
        Notice(category: "공지사항", title: "2024학년도 컴퓨터공학부 캡스톤디자인 수상팀 명단", author: "행정조교", date: "2024-06-04"),
        Notice(category: "공지사항", title: "[공모전] 제12회 산업통상자원부 공공데이터 활용", author: "행정조교", date: "2024-05-28"),
        Notice(category: "공지사항", title: "[모집공고] LG AI연구원 모집", author: "행정조교", date: "2024-05-24"),
        Notice(category: "공지사항", title: "2024 컴퓨터공학부 캡스톤디자인 작품발표회 개최", author: "행정조교", date: "2024-05-23"),
        Notice(category: "공지사항", title: "[졸업] 수료자 대상 2024-8월 졸업 신청 안내", author: "행정조교", date: "2024-05-20"),
        Notice(category: "공지사항", title: "연구원 모집 (박승현 교수님 연구실, MCS Lab.)", author: "행정조교", date: "2024-04-25"),
        Notice(category: "공지사항", title: "[한기준 교수님] AML 랩 (Applied Machine Learning Lab)", author: "행정조교", date: "2024-04-19"),
        Notice(category: "공지사항", title: "(최종)2024-1 컴퓨터공학부 전공튜터링 튜터 추가모집 안내", author: "행정조교", date: "2024-04-09"),
        Notice(category: "공지사항", title: "2024-1 컴퓨터공학부 전공튜터링 튜터 명단 및 튜터링 일정", author: "행정조교", date: "2024-04-05"),
        Notice(category: "공지사항", title: "2024-1 코딩라운지 오픈 및 운영 안내", author: "행정조교", date: "2024-03-18")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 배경색 설정
        self.view.backgroundColor = .white
        // 네비게이션 타이틀 설정
        self.navigationItem.title = "컴퓨터 공학부 공지사항"
        
        // 테이블 뷰 설정 함수 호출
        setupTableView()
    }
    
    // 테이블 뷰 설정 함수
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoticeCell.self, forCellReuseIdentifier: "NoticeCell")
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
    
    // 테이블 뷰 셀 개수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notices.count
    }
    
    // 테이블 뷰 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath) as! NoticeCell
        let notice = notices[indexPath.row]
        cell.configure(with: notice)
        return cell
    }
    
    // 테이블 뷰 셀이 선택되었을 때 호출되는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let notice = notices[indexPath.row]
        let detailVC = NoticeDetailController()
        detailVC.notice = notice
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// 공지사항 구조체 선언
struct Notice {
    let category: String
    let title: String
    let author: String
    let date: String
}

// 테이블 뷰 셀 클래스 선언
class NoticeCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 셀 설정 함수
    func configure(with notice: Notice) {
        titleLabel.text = "[\(notice.category)] \(notice.title) - \(notice.author) (\(notice.date))"
        setupLayout()
    }
    
    // 레이아웃 설정 함수
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
}
