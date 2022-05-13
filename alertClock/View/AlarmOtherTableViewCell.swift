//
//  AlarmOtherTableViewCell.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/25.
//

import UIKit

class AlarmOtherTableViewCell: UITableViewCell {
    
//    var alarm = AlarmInfo()
//    let userNotification = UserNotification()
    
    var callBackSwitchState:((Bool) -> (Void))?
    
    //MARK: - UI
    let lightSwitch:UISwitch = {
        let lightSwitch = UISwitch(frame: .zero)
        lightSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return lightSwitch
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        // 設定accessoryView 為 UISwitch
        self.accessoryView = lightSwitch
        self.editingAccessoryType = .disclosureIndicator
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    func setupUI(){
        textLabel?.font = UIFont.systemFont(ofSize: 50)
        textLabel?.textColor = .lightGray
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    @objc func switchChanged(_ sender : UISwitch){
        callBackSwitchState?(sender.isOn)
//        print("table row switch Changed \(sender.tag)")
        if sender.isOn{
            textLabel?.textColor = .white
            detailTextLabel?.textColor = .white
        }else{
            textLabel?.textColor = .lightGray
            detailTextLabel?.textColor = .lightGray
        }
    }
}
