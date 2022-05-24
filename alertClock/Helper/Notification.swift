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
    var contentHandler: ((UNNotificationContent) -> Void)?
    
    static func addNotificationRequest(alarm: AlarmInfo) {
        
        let current = UNUserNotificationCenter.current()
        //        current.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Clock"
        content.subtitle = "Alarm"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("123.wav"))
        //        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: alarm.date)
        let minute = calendar.component(.minute, from: alarm.date)
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        //測試鬧鐘用的
        //        let date = Date().addingTimeInterval(7)
        //        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        current.add(request) { error in
            if(error == nil){
                print("successfully")
            }else{
                print("error")
            }
        }
    }
    
//    static func addNotificationRequest(alarm: AlarmInfo){
//        addNotificationRequest(title: alarm.note, subTitle: "", id: alarm.id.uuidString)
//    }
}


extension AppDelegate:UNUserNotificationCenterDelegate{
    //app在前台也會通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        completionHandler([.sound, .badge, .banner])
    }
    
    //點選通知完成後會發生的事
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        print("did tap notification")
        completionHandler()
    }
}
