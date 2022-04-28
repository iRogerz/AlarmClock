//
//  AlarmHeaderView.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/28.
//

import UIKit

class AlarmHeaderView: UIView {
    // MARK: - UI
    let headerViewLabel: UILabel = {
        let label = UILabel()
        // 該Label的字體顏色為白色
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let imageView:UIImageView = {
       let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - setupUI
    func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [imageView, headerViewLabel])
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
}
