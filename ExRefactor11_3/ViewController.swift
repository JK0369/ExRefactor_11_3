//
//  ViewController.swift
//  ExRefactor11_3
//
//  Created by 김종권 on 2023/07/17.
//

import UIKit

class ViewController: UIViewController {
    var showName = "iOS 앱 개발 알아가기"
    var date = Date()
    var extraValue = 123.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let booking = Booking(showName: showName, date: date)
        booking.bePremium(extras: extraValue)
    }
}

class Booking {
    let showName: String
    let date: Date
    var premiumDelegate: PremiumBookingDelegate?
    
    init(showName: String, date: Date) {
        self.showName = showName
        self.date = date
    }
    
    func hasTalkback() -> Bool {
        if let premiumDelegate {
            return premiumDelegate.hasTalkback()
        } else {
            // 성수기가 아닐때만 관객과 대화하는 시간을 제공
            return Bool.random()
        }
    }
    
    func bePremium(extras: Double) {
        self.premiumDelegate = .init(extras: extras, hostBooking: self)
    }
}

class PremiumBooking: Booking {
    private let extras: Double
    
    init(showName: String, date: Date, extras: Double) {
        self.extras = extras
        super.init(showName: showName, date: date)
    }
    
    override func hasTalkback() -> Bool {
        // 프리미엄 예약은 항상 관객과 대화하는 시간을 제공
        true
    }
}

struct PremiumBookingDelegate {
    let extras: Double
    let host: Booking // 역참조: 수퍼클래스의 필드에 접근할 때 사용 (상속을 사용할 땐 이게 없어도 되지만 델리게이트 방식은 필요)
    
    init(extras: Double, hostBooking: Booking) {
        self.extras = extras
        self.host = hostBooking
    }
    
    func hasTalkback() -> Bool {
        true
    }
}
