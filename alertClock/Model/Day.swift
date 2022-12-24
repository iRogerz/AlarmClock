//
//  Day.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/5/4.
//

import Foundation

enum Day:Int, Codable, CaseIterable{
    case Sun = 0,Mon,Tue,Wed,Thu,Fri,Sat
    
    var dayString:String{
        switch self {
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
        switch self {
            case .Sun: return "Sun"
            case .Mon: return "Mon"
            case .Tue: return "Tue"
            case .Wed: return "Wed"
            case .Thu: return "Thu"
            case .Fri: return "Fri"
            case .Sat: return "Sat"
        }
    }
    
    var componentWeekday: Int {
        switch self {
            case .Sun: return 1
            case .Mon: return 2
            case .Tue: return 3
            case .Wed: return 4
            case .Thu: return 5
            case .Fri: return 6
            case .Sat: return 7
        }
    }
    
}
