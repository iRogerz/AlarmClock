//
//  RepeatAlarmViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/21.
//

import UIKit

class RepeatAlarmViewController: UIViewController {
    
    var alarmStore = AlarmStore(){
        didSet{
            tableView.reloadData()
        }
    }
    
    //MARK: - UI
    let tableView:UITableView = {
        let myTable = UITableView(frame: CGRect.zero, style: .insetGrouped)
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.tintColor = .orange
        return myTable
    }()
    
    weak var repeatDelegate:UpdateRepeatLabelDelegate?
    
    //把view移除時
    override func viewWillDisappear(_ animated: Bool) {
        repeatDelegate?.updateRepeatLabel(selectedDay: alarmStore.selectDays)
    }
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        overrideUserInterfaceStyle = .dark
        setupUI()
    }
    
    func setupUI(){
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.backBarButtonItem?.title = "Back"
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension RepeatAlarmViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Day.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let isSelected = alarmStore.days[indexPath.row]
        cell.textLabel?.text = isSelected.dayString
//        cell.selectionStyle = .none
        cell.accessoryType = alarmStore.selectDays.contains(isSelected) ? .checkmark : .none
//        if alarm.selectDays.contains(isSelected){
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isSelected = alarmStore.days[indexPath.row]
        print(indexPath.row)
        if alarmStore.selectDays.contains(isSelected){
            alarmStore.selectDays.remove(isSelected)
        }else{
            alarmStore.selectDays.insert(isSelected)
        }
        //點選時有動畫
        tableView.reloadRows(at: [indexPath], with: .automatic)
//        print(alarm.selectDays)
    }
    
}

