//
//  AlarmLabelViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/20.
//

import UIKit

class AlarmLabelViewController: UIViewController,UITextFieldDelegate {

    
    //MARK: - UI
    let textField:UITextField = {
       let myTextField = UITextField()
//        myTextField.backgroundColor = #colorLiteral(red: 0.1734634042, green: 0.1683282256, blue: 0.1771324873, alpha: 1)
        myTextField.returnKeyType = .done
        myTextField.clearButtonMode = .whileEditing
        myTextField.borderStyle = .roundedRect
        return myTextField
    }()
    
    weak var labelDelegate:UpdateAlarmLabelDelegate?
    
    //把view移除時
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
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        textField.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //讓keyboard直接出現在畫面上
        textField.becomeFirstResponder()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


