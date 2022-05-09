//
//  WakeUpTableViewCell.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/25.
//

import UIKit

class WakeUpTableViewCell: UITableViewCell {
    
    
    //MARK: - UI
    
    let settingButton:UIButton = {
        let settingButton = UIButton(frame: .zero)
        settingButton.setTitle("setting", for: .normal)
        settingButton.setTitleColor(.orange, for: .normal)
        settingButton.backgroundColor = .systemGray6
        settingButton.layer.cornerRadius = 15
        settingButton.layer.masksToBounds = true
        return settingButton
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        //暫時無法點擊
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - setupUI
    func setupUI(){
        textLabel?.textColor = .lightGray
        self.addSubview(settingButton)

        settingButton.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-10)
            make.width.equalTo(80)
        }
    }
    
    
}
