//
//  AlarmViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/15.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController{
    
    
    //MARK: - UI
    let alarmTableView:UITableView = {
        let myTable = UITableView(frame: .zero, style: .grouped)
        myTable.separatorStyle = .singleLine
        myTable.register(WakeUpTableViewCell.self, forCellReuseIdentifier: "wakeup")
        myTable.register(AlarmOtherTableViewCell.self, forCellReuseIdentifier: "other")
        return myTable
    }()
    
    var data = [String]()
    
    var alarmDatas: [AddAlarmInfo] = [] {
        didSet{
            alarmTableView.reloadData()
        }
    }
    
    
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
            make.width.height.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
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
    
    //editButton func
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        alarmTableView.setEditing(editing, animated: true)
    }
    
    @objc func addAlarm(){
        let vc = AddAlarmViewController()
        vc.saveAlarmDataDelegate = self
        let addAlarmNC = UINavigationController(rootViewController: vc)
        present(addAlarmNC, animated: true, completion: nil)
    }
    
    func dateToString(date: Date, format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}



//MARK: - tableView
extension AlarmViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return alarmDatas.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "wakeup", for: indexPath) as? WakeUpTableViewCell else {return UITableViewCell()}
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "other", for: indexPath) as? AlarmOtherTableViewCell else {return UITableViewCell()}

            cell.titleLabel.text = dateToString(date: alarmDatas[indexPath.row].time, format: "HH:mm")
            cell.noteLabel.text = alarmDatas[indexPath.row].noteLabel
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = AlarmHeaderView()
        if section == 0{
            headerView.imageView.image = UIImage(systemName: "bed.double.fill")
            headerView.headerViewLabel.text = "Sleep | Wake Up"
            return headerView
        }
        headerView.headerViewLabel.text = "Others"
        return headerView
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1{ return true}
        return false
    }
    //刪除cell 還未完成
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
        }
    }
}

extension AlarmViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddAlarmViewController()
        vc.saveAlarmDataDelegate = self
        let addAlarmNC = UINavigationController(rootViewController: vc)
        present(addAlarmNC, animated: true, completion: nil)
    }
}


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
        // 該View的背景色為黑色
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
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(5)
        }
    }
}




extension AlarmViewController:SaveAlarmInfoDelegate{
    func saveAlarmInfo(alarmData: AddAlarmInfo) {
        self.alarmDatas.append(alarmData)
        
    }
}

protocol SaveAlarmInfoDelegate:AnyObject{
    func saveAlarmInfo(alarmData:AddAlarmInfo)
}

extension Date {
    var localizedDescription: String {
        return description(with: .current)
    }
}

