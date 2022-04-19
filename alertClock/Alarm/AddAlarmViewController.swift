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
    let pickerView: UIPickerView = {
        let myPicker = UIPickerView()
        myPicker.setValue(UIColor.white, forKey: "textColor")
        return myPicker
    }()
    let tableView:UITableView = {
        let myTable = UITableView()
        myTable.layer.cornerRadius = 10
        
        //註冊addalarmtableviewcell
        myTable.register(AddAlarmTableViewCell.self, forCellReuseIdentifier: AddAlarmTableViewCell.identifier)
        
        return myTable
    }()
    
    var times = [[String]]()
    func setupTimes(){
        var tempHR = [String]()
        var tempMin = [String]()
        for i in 0...23{
            i<10 ? tempHR.append("0\(i)") : tempHR.append("\(i)")
        }
        for i in 0...59{
            i<10 ? tempMin.append("0\(i)") : tempMin.append("\(i)")
        }
        times.append(tempHR)
        times.append(tempMin)
    }
    
    let addAlarmTitle = ["Repeat", "Lebal", "Sound", "Snooze"]
    var addAlarmContent = ["Never", "Alarm", "Rader"]
    
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1669761635, green: 0.1807887411, blue: 0.2008549854, alpha: 1)
        
        setupTimes()
        setupUI()
        setupNavigation()
        //        var hr = pickerView.selectRow(0, inComponent: 0, animated: true)
        //        var min = pickerView.selectRow(0, inComponent: 1, animated: true)
    }
    
    //MARK: - setupUI
    func setupUI(){
        
        pickerView.dataSource = self
        pickerView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(pickerView)
        self.view.addSubview(tableView)
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.width.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(18)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(pickerView.snp.bottom).offset(42)
            make.height.equalTo(200)
        }
    }
    
    //MARK: - setup Navigation
    func setupNavigation(){
        navigationItem.title = "Add Alarm"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButton))
        
        //        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1669761635, green: 0.1807887411, blue: 0.2008549854, alpha: 1)
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

//MARK: - UIPicker
extension AddAlarmViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times[component].count
    }
    //    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    //        let attr = NSAttributedString(string: String, attributes: [NSForegroundColorAttributeName:UIColor]?)
    //    }
}

extension AddAlarmViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = times[component][row]
        return title
    }
    
    //讓兩個間距變窄一點
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 66
    }
    
}


//MARK: - UITable
extension AddAlarmViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addAlarmTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        switch indexPath.row{
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmTableViewCell.identifier, for: indexPath) as? AddAlarmTableViewCell else{ return UITableViewCell() }
            cell.titleLabel.text = addAlarmTitle[indexPath.row]
            
            //建立UISwitch 到 tableView
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(false, animated: true)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddAlarmTableViewCell.identifier, for: indexPath) as? AddAlarmTableViewCell else{ return UITableViewCell() }
            cell.titleLabel.text = addAlarmTitle[indexPath.row]
            cell.contentLabel.text = addAlarmContent[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //設tableView背景
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .darkGray
    }
}
