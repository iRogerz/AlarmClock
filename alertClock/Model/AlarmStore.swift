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
            alarms.sort{ $0.time < $1.time }
            saveData()
        }
    }
    var selectDays:Set<Day> = []
    var days:[Day] = Day.allCases
    
    
    init(){
        loadData()
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

enum Day:Int, CaseIterable{
    case Sun = 0,Mon,Tue,Wed,Thu,Fri,Sat
    
    var dayString:String{
        switch self{
            case .Sun: return "Every Sunday"
            case .Mon: return "Every Monday"
            case .Tue: return "Every Tuesday"
            case .Wed: return "Every Wednesday"
            case .Thu: return "Every Thursday"
            case .Fri: return "Every Friday"
            case .Sat: return "Every Saturday"
        }
    }
    
    var dayText:String{
        switch self{
            case .Sun: return "Sun"
            case .Mon: return "Mon"
            case .Tue: return "Tue"
            case .Wed: return "Wed"
            case .Thu: return "Thu"
            case .Fri: return "Fri"
            case .Sat: return "Sat"
        }
    }
    
}
