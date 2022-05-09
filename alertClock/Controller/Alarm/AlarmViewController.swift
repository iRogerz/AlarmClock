//
//  AlarmViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/15.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController{
    
    var alarmStore = AlarmStore(){
        didSet{
            alarmTableView.reloadData()
        }
    }
    
    //MARK: - UI
    let alarmTableView:UITableView = {
        let myTable = UITableView(frame: .zero, style: .grouped)
        myTable.separatorStyle = .singleLine
        myTable.register(WakeUpTableViewCell.self, forCellReuseIdentifier: "wakeup")
        myTable.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: "other")
        return myTable
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmTableView.dataSource = self
        alarmTableView.delegate = self
        setupNavigation()
        setViews()
        setLayouts()
    }
    
    //MARK: - setViews
    func setViews(){
        self.view.addSubview(alarmTableView)
    }
    
    //MARK: - setLayouts
    func setLayouts(){
        
        alarmTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            //            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }
    
    //MARK: - setup Navegation
    func setupNavigation(){
        navigationItem.title = "Alarm"
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm))
        
        //設置顏色
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .orange
        editButtonItem.tintColor = .orange
    }
    
    //editButton
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        alarmTableView.setEditing(editing, animated: true)
    }
    
    @objc func addAlarm(){
        alarmStore.isEdit = false
        let vc = AddAlarmViewController()
        vc.saveAlarmDataDelegate = self
        let addAlarmNC = UINavigationController(rootViewController: vc)
        present(addAlarmNC, animated: true, completion: nil)
    }
    
}

//MARK: - tableView
extension AlarmViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = AlarmSection.allCases[section]
        switch item{
        case .wakeup:
            return 1
        case .other:
            return alarmStore.alarms.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = AlarmSection.allCases[indexPath.section]
        switch item{
        case .wakeup:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "wakeup", for: indexPath) as? WakeUpTableViewCell else {return UITableViewCell()}
            cell.textLabel?.text = "沒有鬧鐘"
            return cell
        case .other:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "other", for: indexPath) as? AlarmOtherTableViewCell else {return UITableViewCell()}
            let alarm = alarmStore.alarms[indexPath.row]
            
            cell.textLabel?.text = alarm.date.toString(format: "HH:mm")
            cell.detailTextLabel?.text = alarm.noteLabel
            cell.lightSwitch.isHidden = alarmTableView.isEditing ? true : false
            cell.lightSwitch.isOn = alarm.isOn
            
            cell.callBackSwitchState = {isOn in
                self.alarmStore.isSwitch(indexPath.row, isOn)
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let item = AlarmSection.allCases[section]
    //        let headerView = AlarmHeaderView()
    //        switch item{
    //        case .wakeup:
    //            headerView.imageView.image = UIImage(systemName: "bed.double.fill")
    //            headerView.headerViewLabel.text = "Sleep | Wake Up"
    //            return headerView
    //        case .other:
    //            headerView.headerViewLabel.text = "Others"
    //            return headerView
    //        }
    //
    //    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let item = AlarmSection.allCases[section]
        switch item{
        case .wakeup:
            return "Sleep | Wake Up"
        case .other:
            return "Other"
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        header.textLabel?.textColor = .white
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    //是否能使用edit編輯
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1{ return true}
        return false
    }
    //刪除cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            alarmStore.remove(indexPath.row)
        }
    }
}

extension AlarmViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            alarmStore.isEdit = true
            let vc = AddAlarmViewController()
            vc.saveAlarmDataDelegate = self
            let alarm = alarmStore.alarms[indexPath.row]
            vc.alarm = alarm
            vc.tempIndexRow = indexPath.row
            let addAlarmNC = UINavigationController(rootViewController: vc)
            present(addAlarmNC, animated: true, completion: nil)
            //取消select的狀態
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}

//MARK: - saveAlarm
extension AlarmViewController:SaveAlarmInfoDelegate{
    func saveAlarmInfo(alarmData: AlarmInfo, index: Int) {
        if alarmStore.isEdit == false{
            alarmStore.append(alarmData)
        }else{
            alarmStore.edit(alarmData, index)
        }
    }
}

protocol SaveAlarmInfoDelegate:AnyObject{
    func saveAlarmInfo(alarmData:AlarmInfo, index: Int)
}


extension AlarmViewController{
    enum AlarmSection:Int, CaseIterable{
        case wakeup = 0, other
    }
}
