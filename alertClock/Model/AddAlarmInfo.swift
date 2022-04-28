//
//  AddAlarmInfo.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/25.
//

import Foundation

struct AddAlarmInfo{
    
    let time:Date
    let note:String
    let day:String
    
//    let index:Int?
    var noteLabel:String{
        if day != "Never" {
            return note + ", " + day
        }
        return note
    }
    
    var isEdit = false
    init(time: Date, note: String, day: String){
        self.time = time
        self.note = note
        self.day = day
    }
    
//    mutating func add(time:Date, note: String){
//        alarmDates.append((time,note))
//    }
}

