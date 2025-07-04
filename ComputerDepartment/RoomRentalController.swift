import UIKit
import FSCalendar

// RoomRentalController 클래스: 강의실 대여 화면을 관리하는 뷰 컨트롤러
class RoomRentalController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    // 스크롤 뷰와 컨텐츠 뷰
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    // UI 요소들
    let calendarView = FSCalendar()
    let roomRentalLabel = UILabel()
    let pickerView = UIPickerView()
    let timeScrollView = UIScrollView()
    let reserveStackView = UIStackView()
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let trackLabel = UILabel()
    let trackTextField = UITextField()
    let phoneLabel = UILabel()
    let phoneTextField = UITextField()
    let reserveButton = UIButton(type: .system)
    
    // 데이터
    let rooms = ["-선택안함-", "공학관 301호", "공학관 201호", "공학관 202호", "공학관 101호", "공학관 102호"]
    var selectedDate: Date? // 단일 날짜를 위한 변수
    var selectedRoom: String?
    var selectedTimeSlots: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 255/255, alpha: 1)
        self.navigationItem.title = "강의실 대여"
        
        // UI 설정 메서드 호출
        setupScrollView()
        setupCalendarView()
        setupRoomRentalLabel()
        setupPickerView()
        setupTimeScrollView()
        setupTextFields()
        setupReserveButton()
    }
    
    // 스크롤 뷰 설정
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    // 캘린더 뷰 설정
    private func setupCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = UIColor(red: 241/255, green: 249/255, blue: 255/255, alpha: 1)
        calendarView.appearance.selectionColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        calendarView.appearance.todayColor = UIColor(red: 188/255, green: 224/255, blue: 253/255, alpha: 1)
        calendarView.allowsMultipleSelection = false // 다중 선택 비활성화
        calendarView.swipeToChooseGesture.isEnabled = true
        calendarView.scrollEnabled = true
        calendarView.scrollDirection = .vertical
        
        contentView.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            calendarView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    // 강의실 대여 라벨 설정
    private func setupRoomRentalLabel() {
        roomRentalLabel.text = "강의실 대여"
        roomRentalLabel.font = UIFont.boldSystemFont(ofSize: 16)
        roomRentalLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(roomRentalLabel)
        
        NSLayoutConstraint.activate([
            roomRentalLabel.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 20),
            roomRentalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
    // 피커 뷰 설정
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: roomRentalLabel.bottomAnchor, constant: 10),
            pickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            pickerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // 시간 슬롯을 표시할 스크롤 뷰 설정
    private func setupTimeScrollView() {
        timeScrollView.translatesAutoresizingMaskIntoConstraints = false
        timeScrollView.showsHorizontalScrollIndicator = false
        contentView.addSubview(timeScrollView)
        
        reserveStackView.axis = .horizontal
        reserveStackView.spacing = 10
        reserveStackView.distribution = .fillEqually
        reserveStackView.translatesAutoresizingMaskIntoConstraints = false
        timeScrollView.addSubview(reserveStackView)
        
        NSLayoutConstraint.activate([
            timeScrollView.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            timeScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            timeScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            reserveStackView.topAnchor.constraint(equalTo: timeScrollView.topAnchor),
            reserveStackView.bottomAnchor.constraint(equalTo: timeScrollView.bottomAnchor),
            reserveStackView.leadingAnchor.constraint(equalTo: timeScrollView.leadingAnchor),
            reserveStackView.trailingAnchor.constraint(equalTo: timeScrollView.trailingAnchor),
            reserveStackView.heightAnchor.constraint(equalTo: timeScrollView.heightAnchor)
        ])
    }
    
    // 텍스트 필드 설정
    private func setupTextFields() {
        nameLabel.text = "이름"
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameTextField)
        
        trackLabel.text = "트랙"
        trackLabel.font = UIFont.systemFont(ofSize: 14)
        trackLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trackLabel)
        
        trackTextField.borderStyle = .roundedRect
        trackTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trackTextField)
        
        phoneLabel.text = "전화번호"
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(phoneLabel)
        
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(phoneTextField)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: timeScrollView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            trackLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            trackLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            trackTextField.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 5),
            trackTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trackTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            trackTextField.heightAnchor.constraint(equalToConstant: 30),
            
            phoneLabel.topAnchor.constraint(equalTo: trackTextField.bottomAnchor, constant: 20),
            phoneLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
            phoneTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            phoneTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // 예약 버튼 설정
    private func setupReserveButton() {
        reserveButton.setTitle("예약하기", for: .normal)
        reserveButton.addTarget(self, action: #selector(finalReserveButtonTapped), for: .touchUpInside)
        reserveButton.translatesAutoresizingMaskIntoConstraints = false
        reserveButton.backgroundColor = UIColor(red: 38/255, green: 153/255, blue: 251/255, alpha: 1)
        reserveButton.setTitleColor(.white, for: .normal)
        reserveButton.layer.cornerRadius = 10
        contentView.addSubview(reserveButton)
        
        NSLayoutConstraint.activate([
            reserveButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20),
            reserveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            reserveButton.widthAnchor.constraint(equalToConstant: 200),
            reserveButton.heightAnchor.constraint(equalToConstant: 50),
            reserveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // 예약 시간을 선택할 버튼 생성
    private func createReserveButtons(for date: Date) {
        reserveStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let timeSlots = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00"]
        for slot in timeSlots {
            let button = UIButton(type: .system)
            button.setTitle(slot, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.addTarget(self, action: #selector(timeSlotButtonTapped(_:)), for: .touchUpInside)
            reserveStackView.addArrangedSubview(button)
        }
    }
    
    // 시간 슬롯 버튼 클릭 시 호출되는 메서드
    @objc private func timeSlotButtonTapped(_ sender: UIButton) {
        guard let slot = sender.titleLabel?.text else { return }
        
        if let index = selectedTimeSlots.firstIndex(of: slot) {
            selectedTimeSlots.remove(at: index)
            sender.backgroundColor = .white
            sender.setTitleColor(.black, for: .normal)
            sender.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            selectedTimeSlots.append(slot)
            sender.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1) // 파스텔톤 파란색
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderColor = UIColor(red: 70/255, green: 130/255, blue: 180/255, alpha: 1).cgColor // 더 진한 파스텔톤 파란색
        }
    }
    
    // 최종 예약 버튼 클릭 시 호출되는 메서드
    @objc private func finalReserveButtonTapped() {
        // 입력 값 검증
        guard !selectedTimeSlots.isEmpty,
              let room = selectedRoom,
              selectedRoom != "-선택안함-",
              let selectedDate = selectedDate,
              let name = nameTextField.text, !name.isEmpty,
              let track = trackTextField.text, !track.isEmpty,
              let phone = phoneTextField.text, isValidPhoneNumber(phone) else {
            let alert = UIAlertController(title: "예약 실패", message: "모든 항목을 올바르게 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // FirebaseManager를 사용하여 예약 정보를 저장
        FirebaseManager.shared.saveReservation(name: name, track: track, phone: phone, room: room, dates: [selectedDate], timeSlots: selectedTimeSlots) { [weak self] error in
            guard let self = self else { return }
            let title = (error == nil) ? "예약 완료" : "예약 실패"
            let message = (error == nil) ? "예약이 성공적으로 완료되었습니다." : "예약 저장 중 오류가 발생했습니다."
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                if error == nil {
                    self.clearInputFields()
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // 입력 필드를 초기화하는 메서드
    private func clearInputFields() {
        nameTextField.text = ""
        trackTextField.text = ""
        phoneTextField.text = ""
        selectedDate = nil
        selectedTimeSlots.removeAll()
        selectedRoom = nil
        pickerView.selectRow(0, inComponent: 0, animated: true)
        calendarView.reloadData()
        createReserveButtons(for: Date())
    }
    
    // 전화번호 유효성을 검사하는 메서드
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9]{3}-[0-9]{3,4}-[0-9]{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    // FSCalendar Delegate 및 DataSource 메서드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        createReserveButtons(for: date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = nil
        createReserveButtons(for: Date())
    }
    
    // UIPickerView Delegate 및 DataSource 메서드
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rooms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return rooms[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRoom = rooms[row]
    }
}
