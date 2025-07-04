import UIKit
import Firebase

class RentalStatusController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableView = UITableView()
    var reservations: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "예약 현황"
        
        setupTableView()
        fetchReservations()
    }

    // 테이블 뷰 설정
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RentalStatusCell.self, forCellReuseIdentifier: "RentalStatusCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // Firebase에서 예약 정보 가져오기
    private func fetchReservations() {
        FirebaseManager.shared.fetchReservations { [weak self] (documents, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                self.reservations = documents?.map { doc -> [String: Any] in
                    var data = doc.data()
                    data["documentID"] = doc.documentID
                    return data
                } ?? []
                self.tableView.reloadData()
            }
        }
    }

    // UITableViewDataSource 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RentalStatusCell", for: indexPath) as! RentalStatusCell
        let reservation = reservations[indexPath.row]
        cell.configure(with: reservation)
        return cell
    }
    
    // 테이블 뷰 항목 삭제 기능 추가
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let reservation = reservations[indexPath.row]
            if let documentID = reservation["documentID"] as? String {
                FirebaseManager.shared.deleteReservation(documentID: documentID) { [weak self] error in
                    guard let self = self else { return }
                    if let error = error {
                        print("Error deleting document: \(error)")
                    } else {
                        if indexPath.row < self.reservations.count {
                            self.reservations.remove(at: indexPath.row)
                            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        }
                    }
                }
            }
        }
    }

    // 테이블 뷰 항목 클릭 시 예약 상세 보기 기능 추가
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let reservation = reservations[indexPath.row]
        let detailVC = ReservationDetailViewController()
        detailVC.reservation = reservation
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
