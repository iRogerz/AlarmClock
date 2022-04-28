//
//  AlarmStore.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/27.
//

import Foundation

struct AlarmStore{
    
    
    var isEdit = false
    private(set) var alarms:[AddAlarmInfo] = []{
        didSet{
            alarms.sort{ $0.time < $1.time }
        }
    }
    
    mutating func edit(_ alarmData:AddAlarmInfo,_ index: Int){
        alarms[index] = alarmData
    }
    
    mutating func remove(_ index:Int){
        alarms.remove(at: index)
    }
    
    mutating func append(_ alarmData:AddAlarmInfo){
        alarms.append(alarmData)
    }
    
    
}
