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
//    var alarmDates:[(time:Date,note:String)] = []
    init(time: Date, note: String){
        self.time = time
        self.note = note
    }
//    mutating func add(time:Date, note: String){
//        alarmDates.append((time,note))
//    }
}
