//
//  AlarmInfo.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/25.
//

import Foundation

struct AlarmInfo:Codable{
    
    var time:Date = Date()
    var note:String = "Alarm"
    var day:String = "Never"
    var noteLabel:String{
        if day != "Never" {
            return note + ", " + day
        }
        return note
    }
    
    var isEdit = false
    
}


