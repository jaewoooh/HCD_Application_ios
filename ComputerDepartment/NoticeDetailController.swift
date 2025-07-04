import UIKit

// NoticeDetailController 클래스: 공지사항의 세부 정보를 표시하는 뷰 컨트롤러
class NoticeDetailController: UIViewController {
    // 공지사항 데이터를 저장하는 변수
    var notice: Notice?

    // 공지사항 세부 정보를 표시할 UILabel 요소들
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let dateLabel = UILabel()
    let categoryLabel = UILabel()
    let contentLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰의 배경색을 흰색으로 설정
        view.backgroundColor = .white
        // UI 구성 요소 설정
        setupUI()
        // 공지사항 세부 정보 표시
        displayNoticeDetails()
    }
    
    // UI 구성 요소를 설정하는 메서드
    private func setupUI() {
        // UILabel의 폰트 및 속성 설정
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        authorLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        categoryLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 0
        
        // UIStackView를 사용하여 레이블들을 수직으로 정렬
        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, dateLabel, categoryLabel, contentLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        // 스택 뷰의 자동 레이아웃 설정
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // 스택 뷰의 제약 조건 설정
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    // 공지사항 세부 정보를 표시하는 메서드
    private func displayNoticeDetails() {
        guard let notice = notice else { return }
        
        // 공지사항 데이터를 UILabel에 설정
        titleLabel.text = notice.title
        authorLabel.text = "작성자: \(notice.author)"
        dateLabel.text = "작성일: \(notice.date)"
        categoryLabel.text = "카테고리: \(notice.category)"
        contentLabel.text = "공지 내용: 여기 공지사항의 상세 내용을 추가하세요."
    }
}
