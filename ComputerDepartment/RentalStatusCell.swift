import UIKit

class RentalStatusCell: UITableViewCell {
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
    
    func configure(with reservation: [String: Any]) {
        let name = reservation["name"] as? String ?? "No Name"
        let room = reservation["room"] as? String ?? "No Room"
        let timeSlots = (reservation["timeSlots"] as? [String])?.joined(separator: ", ") ?? "No Time Slots"
        
        let dates: String
        if let dateArray = reservation["dates"] as? [String], dateArray.count > 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let sortedDates = dateArray.sorted()
            let startDate = sortedDates.first!
            let endDate = sortedDates.last!
            dates = "\(startDate) ~ \(endDate)"
        } else if let dateArray = reservation["dates"] as? [String], let singleDate = dateArray.first {
            dates = singleDate
        } else {
            dates = "No Dates"
        }
        
        titleLabel.text = "이름: \(name)\n기자재: \(room)\n날짜: \(dates)\n시간: \(timeSlots)"
        setupLayout()
    }
    
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
