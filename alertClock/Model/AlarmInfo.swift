//
//  AlarmInfo.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/25.
//

import Foundation

struct AlarmInfo:Codable{
    
    var id = UUID()
    var date:Date = Date()
    var note:String = "Alarm"
    var noteLabel:String{
        return note + ", " + repeatDay
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


