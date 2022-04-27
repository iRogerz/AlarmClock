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
        label.text = "05:50"
        label.textColor = .lightGray
        return label
    }()
    
    let noteLabel:UILabel = {
        let label = UILabel()
        label.text = "吃香蕉"
        label.textColor = .lightGray
        return label
    }()
    
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        // 設定accessoryView 為 UISwitch
        self.accessoryView = UISwitch(frame: .zero)
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

}
