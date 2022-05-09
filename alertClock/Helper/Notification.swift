//
//  Notification.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/5/5.
//

import Foundation
import NotificationCenter
import AVFoundation


class UserNotification{
    static func addNotificationRequest(alarm: AlarmInfo){
        let current = UNUserNotificationCenter.current()
        
//        current.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Clock"
        content.subtitle = "Alarm"
        //        content.categoryIdentifier = "alarm"
//        content.sound =
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: alarm.date)
        let minute = calendar.component(.minute, from: alarm.date)
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        //測試鬧鐘用的
//        let date = Date().addingTimeInterval(5)
//        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        print(request)
        current.add(request)
    }
}
