import Firebase
import FirebaseFirestore

// FirebaseManager 클래스: Firebase Firestore와의 상호작용을 관리하는 싱글톤 클래스
class FirebaseManager {
    // 싱글톤 인스턴스
    static let shared = FirebaseManager()
    // Firestore 데이터베이스 참조
    let db = Firestore.firestore()
    
    // private init()을 통해 외부에서 인스턴스 생성을 막음
    private init() {}
    
    // 예약 정보를 Firestore에 저장하는 메서드
    func saveReservation(name: String, track: String, phone: String, room: String, dates: [Date], timeSlots: [String], completion: @escaping (Error?) -> Void) {
        // DateFormatter를 사용하여 날짜를 문자열로 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStrings = dates.map { formatter.string(from: $0) }
        
        // 예약 정보를 딕셔너리 형태로 준비
        var reservation: [String: Any] = [
            "name": name,
            "track": track,
            "phone": phone,
            "room": room,
            "dates": dateStrings,
            "timeSlots": timeSlots
        ]
        
        // Firestore 컬렉션에 새로운 문서를 생성하고 문서 ID를 추가
        let document = db.collection("reservations").document()
        reservation["documentID"] = document.documentID
        
        // 예약 정보를 Firestore에 저장
        document.setData(reservation) { error in
            completion(error)
        }
    }

    // Firestore에서 예약 정보를 가져오는 메서드
    func fetchReservations(completion: @escaping ([QueryDocumentSnapshot]?, Error?) -> Void) {
        // 컬렉션의 모든 문서에 대한 실시간 업데이트를 수신하는 리스너 추가
        db.collection("reservations").addSnapshotListener { querySnapshot, error in
            // 쿼리 결과와 오류를 completion 핸들러로 전달
            completion(querySnapshot?.documents, error)
        }
    }

    // Firestore에서 예약 정보를 삭제하는 메서드
    func deleteReservation(documentID: String, completion: @escaping (Error?) -> Void) {
        // 특정 문서를 문서 ID로 참조하여 삭제
        db.collection("reservations").document(documentID).delete { error in
            completion(error)
        }
    }
}

