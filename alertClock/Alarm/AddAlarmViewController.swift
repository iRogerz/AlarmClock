//
//  AddAlarmViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/18.
//

import UIKit
import SnapKit

class AddAlarmViewController: UIViewController {
    
    //MARK: - UI& Variable
    let datePicker:UIDatePicker = {
        let myPicker = UIDatePicker()
        myPicker.datePickerMode = .time
        myPicker.locale = Locale(identifier: "NL")
        myPicker.preferredDatePickerStyle = .wheels
        return myPicker
    }()

    let tableView:UITableView = {
        let myTable = UITableView()
        myTable.layer.cornerRadius = 10
        //註冊addalarmtableviewcell
        myTable.register(AddAlarmTableViewCell.self, forCellReuseIdentifier: AddAlarmTableViewCell.identifier)
        
        return myTable
    }()
//    let switchView:UISwitch = {
//        let mySwitch = UISwitch()
//        mySwitch.frame = .zero
//        mySwitch.setOn(false, animated: true)
//        mySwitch.addTarget(AddAlarmViewController.self, action: #selector(switchChanged(_:)), for: .valueChanged)
//        return mySwitch
//    }()

    
    let addAlarmTitle = ["Repeat", "Lebal", "Sound", "Snooze"]
    var addAlarmContent = ["Never", "Alarm", "Rader",]{
        didSet{
            tableView.reloadData()
        }
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkText
        //目前無用!!!
        overrideUserInterfaceStyle = .dark
        setupUI()
        setupNavigation()
      
    }
    
    //MARK: - setupUI
    func setupUI(){
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(datePicker)
        self.view.addSubview(tableView)
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(view).offset(48)
            make.width.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(18)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(datePicker.snp.bottom).offset(42)
            make.height.equalTo(200)
        }
    }
    
    //MARK: - setup Navigation
    func setupNavigation(){
        navigationItem.title = "Add Alarm"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButton))
    
        //設定各物件顏色
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem?.tintColor = .orange
    }
    
    @objc func cancelButton(){
        
    }
    
    @objc func saveButton(){
        
    }
    @objc func switchChanged(_ sender : UISwitch!){
          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    
}

//MARK: - UITableView
extension AddAlarmViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addAlarmTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmTableViewCell.identifier, for: indexPath) as? AddAlarmTableViewCell else{ return UITableViewCell() }
            cell.titleLabel.text = addAlarmTitle[indexPath.row]
            
//            建立UISwitch 到 tableView
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(false, animated: true)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            print(addAlarmContent)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmTableViewCell.identifier, for: indexPath) as? AddAlarmTableViewCell else{ return UITableViewCell() }
            cell.titleLabel.text = addAlarmTitle[indexPath.row]
            cell.contentLabel.text = addAlarmContent[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            break
        case 1:
            let vc = AlarmLabelViewController()
            vc.labelDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
    //tableView高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


//
extension AddAlarmViewController:UpdateAlarmLabelDelegate{
    func updateAlarmLabel(alarmLabelText: String) {
        self.addAlarmContent[1] = alarmLabelText
    }
}

//使用delegate傳值
protocol UpdateAlarmLabelDelegate:AnyObject{
    func updateAlarmLabel(alarmLabelText: String)
}
