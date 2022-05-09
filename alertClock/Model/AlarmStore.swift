//
//  AlarmStore.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/27.
//

import Foundation

struct AlarmStore{
    
    private let userDefault = UserDefaults.standard
    var isEdit = false
    private(set) var alarms:[AlarmInfo] = []{
        didSet{
            alarms.sort{ $0.date < $1.date }
            saveData()
        }
    }
    
    init(){
        loadData()
    }
    mutating func isSwitch(_ index: Int,_ tableViewCellisOn:Bool){
        alarms[index].isOn = tableViewCellisOn
    }
    mutating func edit(_ alarmData:AlarmInfo,_ index: Int){
        alarms[index] = alarmData
    }
    
    mutating func remove(_ index:Int){
        alarms.remove(at: index)
    }
    
    mutating func append(_ alarmData:AlarmInfo){
        alarms.append(alarmData)
    }
    
    private func saveData(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(alarms) {
            let defaults = userDefault
            defaults.set(encoded, forKey: "data")
        }
    }
    
    private mutating func loadData(){
        if let saveData = userDefault.object(forKey: "data") as? Data {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(Array<AlarmInfo>.self, from: saveData) {
                alarms = loadedData
            }
        }
    }

    
}


