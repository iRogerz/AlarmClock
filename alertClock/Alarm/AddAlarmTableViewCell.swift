//
//  AddAlarmTableViewCell.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/19.
//

import UIKit

class AddAlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AddAlarmTableViewCell"
    
    //MARK: - setupUI
    let titleLabel:UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .white
        return myLabel
    }()
    
    let contentLabel:UILabel = {
        let myLabel = UILabel()
        myLabel.textColor = .lightGray
        return myLabel
    }()

    let detailImageView: UIImageView = {
            // 設定這個 imageView 的圖案為 "chevron.right"
            let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
            // 設定這個 imageView 的顏色為灰色
            imageView.tintColor = .lightGray
            return imageView
        }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //顯示 ">" 符號
        self.accessoryView = detailImageView
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)

        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).offset(14)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.trailing.equalTo(self).offset(-50)
        }

    }
    
    
    
}
