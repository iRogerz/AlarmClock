//
//  DateExtension.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/27.
//

import Foundation

extension Date{
    
    func toString(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    var localizedDescription: String {
        return description(with: .current)
    }

}
