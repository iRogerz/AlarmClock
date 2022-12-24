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
    
    static let shared = UserNotification()
    
    let current = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    
    func addNotificationRequest(alarm: AlarmInfo) {
//        current.removeAllPendingNotificationRequests()
        content.title = "Clock"
        content.subtitle = "Alarm"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("123.wav"))
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: alarm.date)
        let minute = calendar.component(.minute, from: alarm.date)
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        if alarm.selectDays.isEmpty {
            triggerRequest(dateComponents: dateComponents, alarm: alarm, isRepeat: false)
        } else {
            let weekdays = alarm.selectDays.map { $0.componentWeekday }
            weekdays.forEach { weekDay in
                dateComponents.weekday = weekDay
                triggerRequest(dateComponents: dateComponents, alarm: alarm)
            }
        }
    }
    
    func triggerRequest(dateComponents: DateComponents, alarm: AlarmInfo, isRepeat: Bool = true) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isRepeat)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        current.add(request) { error in
            if(error == nil){
                print("successfully")
            }else{
                print("error")
            }
        }
    }

}


