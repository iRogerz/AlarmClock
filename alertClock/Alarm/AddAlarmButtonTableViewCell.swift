//
//  AddAlarmButtonTableViewCell.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/21.
//

import UIKit

//為了要製作UISwitch多新建了一個cell
class AddAlarmButtonTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryView = UISwitch()
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let titleLabel:UILabel = {
       let myLabel = UILabel()
        
        return myLabel
    }()
    
    static let identifier = "addAlarmButtonTableViewCell"
    
    func setupUI(){
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            // titleLabel 的頂部跟底部貼齊TableViewCell的頂部跟底部
            make.top.bottom.equalTo(self)
            // titleLabel 的左邊距離TableViewCell的左邊間隔14
            make.leading.equalTo(self).offset(14)
        }
    }
}
