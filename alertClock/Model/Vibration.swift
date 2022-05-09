//
//  Vibration.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/5/6.
//

import Foundation
import AudioToolbox

//enum Vibration {
//        case error
//        case success
//        case warning
//        case light
//        case medium
//        case heavy
//        @available(iOS 13.0, *)
//        case soft
//        @available(iOS 13.0, *)
//        case rigid
//        case selection
//        case oldSchool
//
//        public func vibrate() {
//            switch self {
//            case .error:
//                UINotificationFeedbackGenerator().notificationOccurred(.error)
//            case .success:
//                UINotificationFeedbackGenerator().notificationOccurred(.success)
//            case .warning:
//                UINotificationFeedbackGenerator().notificationOccurred(.warning)
//            case .light:
//                UIImpactFeedbackGenerator(style: .light).impactOccurred()
//            case .medium:
//                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
//            case .heavy:
//                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
//            case .soft:
//                if #available(iOS 13.0, *) {
//                    UIImpactFeedbackGenerator(style: .soft).impactOccurred()
//                }
//            case .rigid:
//                if #available(iOS 13.0, *) {
//                    UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
//                }
//            case .selection:
//                UISelectionFeedbackGenerator().selectionChanged()
//            case .oldSchool:
//                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//            }
//        }
//    }

@propertyWrapper
struct SoundId {
    typealias Value = UInt32
    var projectedValue: SystemSoundID
    var wrappedValue: Value {
        didSet {
            projectedValue = .init(self.wrappedValue)
        }
    }
    
    init(wrappedValue: Value) {
        self.projectedValue = SystemSoundID(wrappedValue)
        self.wrappedValue = wrappedValue
    }
}

class SoundClass {
    @SoundId var currentSystemEffect = kSystemSoundID_Vibrate
    
    func playSound() {
        AudioServicesPlaySystemSound(self.$currentSystemEffect)
    }
}
