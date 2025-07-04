import UIKit

class ReservationDetailViewController: UIViewController {
    var reservation: [String: Any]?

    let nameLabel = UILabel()
    let roomLabel = UILabel()
    let datesLabel = UILabel()
    let timeSlotsLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "예약 상세"

        setupLabels()
        setupConstraints()
        populateData()
    }

    private func setupLabels() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        datesLabel.translatesAutoresizingMaskIntoConstraints = false
        timeSlotsLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(nameLabel)
        view.addSubview(roomLabel)
        view.addSubview(datesLabel)
        view.addSubview(timeSlotsLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            roomLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            roomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            roomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            datesLabel.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 20),
            datesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            timeSlotsLabel.topAnchor.constraint(equalTo: datesLabel.bottomAnchor, constant: 20),
            timeSlotsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeSlotsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func populateData() {
        guard let reservation = reservation else { return }

        let name = reservation["name"] as? String ?? "No Name"
        let room = reservation["room"] as? String ?? "No Room"
        
        let dates: String
        if let dateArray = reservation["dates"] as? [String], dateArray.count > 1 {
            let sortedDates = dateArray.sorted()
            let startDate = sortedDates.first!
            let endDate = sortedDates.last!
            dates = "\(startDate) ~ \(endDate)"
        } else if let dateArray = reservation["dates"] as? [String], let singleDate = dateArray.first {
            dates = singleDate
        } else {
            dates = "No Dates"
        }
        
        let timeSlots = (reservation["timeSlots"] as? [String])?.joined(separator: ", ") ?? "No Time Slots"

        nameLabel.text = "이름: \(name)"
        roomLabel.text = "강의실: \(room)"
        datesLabel.text = "날짜: \(dates)"
        timeSlotsLabel.text = "시간: \(timeSlots)"
    }
}
