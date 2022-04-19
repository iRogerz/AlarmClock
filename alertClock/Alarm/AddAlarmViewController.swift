//
//  AddAlarmViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/18.
//

import UIKit
import SnapKit

class AddAlarmViewController: UIViewController {
    
    //MARK: - UI
    let pickerView: UIPickerView = {
       let myPicker = UIPickerView()
        return myPicker
    }()
    let tableView:UITableView = {
       let myTable = UITableView()
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        pickerView.dataSource = self
        pickerView.delegate = self
        setupNavigation()
        setupUI()
        setupTimes()
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.selectRow(1, inComponent: 0, animated: true)
    }
    
    //MARK: - setupUI
    func setupUI(){
        self.view.addSubview(pickerView)
        self.view.addSubview(tableView)
        
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.width.equalTo(view)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.top.equalTo(pickerView.snp.bottom).offset(50)
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
}

extension AddAlarmViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return times[component].count
    }
}

extension AddAlarmViewController:UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = times[component][row]
        return title
    }
}
