//
//  AddAlarmViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/18.
//

import UIKit

class AddAlarmViewController: UIViewController {

    
    var alarm = AlarmInfo(){
        didSet{
            datePicker.date = alarm.time
            addAlarmContent[0] = alarm.day
            addAlarmContent[1] = alarm.note
            tableView.reloadData()
        }
    }
    var alarmStore = AlarmStore()
    
    //MARK: - UI
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
        myTable.isScrollEnabled = false
        //註冊addalarmtableviewcell
        myTable.register(AddAlarmTableViewCell.self, forCellReuseIdentifier: AddAlarmTableViewCell.identifier)
        //註冊addalarmButtontableviewcell
        myTable.register(AddAlarmButtonTableViewCell.self, forCellReuseIdentifier: AddAlarmButtonTableViewCell.identifier)
        
        return myTable
    }()
    
    let addAlarmTitle = ["Repeat", "Lebal", "Sound", "Snooze"]
    var addAlarmContent = ["Never", "Alarm", "Rader"]{
        didSet{
            tableView.reloadData()
        }
    }
    var tempIndexRow:Int = 0
    
    weak var saveAlarmDataDelegate: SaveAlarmInfoDelegate?
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        //尋求幫助 不知道怎麼要才可以讓背景不透明
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
        self.dismiss(animated: true)
    }
    
    @objc func saveButton(){
        saveAlarmDataDelegate?.saveAlarmInfo(alarmData: alarm, index: tempIndexRow)
        self.dismiss(animated: true)
    }
//    @objc func switchChanged(_ sender : UISwitch!){
//        print("table row switch Changed \(sender.tag)")
//        print("The switch is \(sender.isOn ? "ON" : "OFF")")
//    }
    
}

//MARK: - UITableView
extension AddAlarmViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addAlarmTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmButtonTableViewCell.identifier, for: indexPath) as? AddAlarmButtonTableViewCell else{ return UITableViewCell() }
            cell.titleLabel.text = addAlarmTitle[indexPath.row]
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
            let repeatVC = RepeatAlarmViewController()
            repeatVC.repeatDelegate = self
            repeatVC.alarmStore.selectDays = alarmStore.selectDays
            self.navigationController?.pushViewController(repeatVC, animated: true)
        case 1:
            let labelVC = AlarmLabelViewController()
            labelVC.textField.text = alarm.note
            labelVC.labelDelegate = self
            self.navigationController?.pushViewController(labelVC, animated: true)
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

extension AddAlarmViewController:UpdateAlarmLabelDelegate{
    func updateAlarmLabel(alarmLabelText: String) {
        alarm.note = alarmLabelText
        addAlarmContent[1] = alarmLabelText
    }
}

extension AddAlarmViewController:UpdateRepeatLabelDelegate{
    func updateRepeatLabel(selectedDay: Set<Day>) {
        alarmStore.selectDays = selectedDay
        let repeatDay = alarmStore.repeatDay
        alarm.day = repeatDay
        addAlarmContent[0] = repeatDay
    }
}


//MARK: - protocol使用delegate傳值
protocol UpdateAlarmLabelDelegate:AnyObject{
    func updateAlarmLabel(alarmLabelText: String)
}

protocol UpdateRepeatLabelDelegate:AnyObject{
    func updateRepeatLabel(selectedDay:Set<Day>)
}


