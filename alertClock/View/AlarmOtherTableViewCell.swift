//
//  AlarmOtherTableViewCell.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/25.
//

import UIKit

class AlarmOtherTableViewCell: UITableViewCell {
    
    //MARK: - UI
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        // 先暫時給個假定時間
//        label.text = "05:50"
        label.textColor = .lightGray
        return label
    }()
    
    let noteLabel:UILabel = {
        let label = UILabel()
//        label.text = "吃香蕉"
        label.textColor = .lightGray
        return label
    }()
    
    let lightSwitch:UISwitch = {
        let lightSwitch = UISwitch(frame: .zero)
        lightSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return lightSwitch
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        // 設定accessoryView 為 UISwitch
        self.accessoryView = lightSwitch
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupUI
    func setupUI(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(noteLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
        }
        noteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(self).offset(-10)
        }
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        if sender.isOn{
            titleLabel.textColor = .white
            noteLabel.textColor = .white
        }else{
            titleLabel.textColor = .lightGray
            noteLabel.textColor = .lightGray
        }
//        print("table row switch Changed \(sender.tag)")
//        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }

}
