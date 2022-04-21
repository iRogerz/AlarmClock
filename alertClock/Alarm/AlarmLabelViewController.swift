//
//  AlarmLabelViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/20.
//

import UIKit
import SnapKit

class AlarmLabelViewController: UIViewController {

    
    //MARK: - UI
    let textField:UITextField = {
       let myTextField = UITextField()
        myTextField.text = ""
        myTextField.backgroundColor = #colorLiteral(red: 0.1734634042, green: 0.1683282256, blue: 0.1771324873, alpha: 1)
        myTextField.returnKeyType = .done
        myTextField.clearButtonMode = .whileEditing
        myTextField.borderStyle = .roundedRect
        
        //讓keyboard直接出現在畫面上
        myTextField.becomeFirstResponder()
        return myTextField
    }()
    
    var labelDelegate:UpdateAlarmLabelDelegate?
    
    
    //不太清楚要詢問
    override func viewWillDisappear(_ animated: Bool) {
            
            if let text = textField.text {
                if text == "" { // 若輸入框內為空白，回傳 Alarm
                    labelDelegate?.updateAlarmLabel(alarmLabelText: "Alarm")
                }else { // 若輸入框內不為空白，回傳「輸入框內的文字」
                    labelDelegate?.updateAlarmLabel(alarmLabelText: text)
                }
            }
        }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkText
        overrideUserInterfaceStyle = .dark
        
        setupUI()
    }
            
    //MARK: - SetupUI
    func setupUI(){
        
        navigationController?.navigationBar.tintColor = .orange

        self.title = "Lebal"
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view).offset(-120)
            make.height.equalTo(45)
        }
    }
    
    
    //鍵盤不會關掉
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
    }
    
    
}


