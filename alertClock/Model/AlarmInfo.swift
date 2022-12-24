//
//  AlarmInfo.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/25.
//

import Foundation
import UserNotifications



struct AlarmInfo:Codable{
    
    var id = UUID()
    var date:Date = Date()
    var note:String = "Alarm"
    var noteLabel:String{
        if repeatDay == "Never"{
            return note
        }
        return note + ", " + repeatDay
    }
    
    var isOn: Bool = true {
        didSet{
            if isOn{
                UserNotification.shared.addNotificationRequest(alarm: self)
            }else{
                // 刪除推播
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(self.id.uuidString)"])
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(self.id.uuidString)"])
            }
        }
    }
    
    var selectDays:Set<Day> = []
    
    var isEdit = false
    
    var repeatDay:String{
        switch selectDays{
        case [.Sat, .Sun]:
            return "Weekend"
        case [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]:
            return "Every day"
        case [.Mon, .Tue, .Wed, .Thu, .Fri]:
            return "Weekdays"
        case []:
            return "Never"
        default:
            let day = selectDays.sorted(by: {$0.rawValue < $1.rawValue}).map{$0.dayText}.joined(separator: " ")
            return day
        }
    }
}


