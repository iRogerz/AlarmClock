//
//  WakeUpTableViewCell.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/25.
//

import UIKit

class WakeUpTableViewCell: UITableViewCell {
    
//    static let identifier = "wakeUpTableViewCell"
    
    //MARK: - UI
    let wakeupLebal:UILabel = {
        let wakeupLebal = UILabel()
        wakeupLebal.text = "沒有鬧鐘"
        return wakeupLebal
    }()
    
    let settingButton:UIButton = {
        let settingButton = UIButton()
        settingButton.setTitle("setting", for: .normal)
        settingButton.setTitleColor(.orange, for: .normal)
        settingButton.backgroundColor = .gray
//        settingButton.layer.borderColor = UIColor.gray.cgColor
        settingButton.layer.cornerRadius = 10
        return settingButton
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - setupUI
    func setupUI(){
        self.addSubview(wakeupLebal)
        self.addSubview(settingButton)
        
        wakeupLebal.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(10)
        }
        settingButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-10)
        }
    }
    
    
}
