//
//  RepeatAlarmViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/21.
//

import UIKit
import SnapKit

class RepeatAlarmViewController: UIViewController {

    
    //MARK: - UI
    let tableView:UITableView = {
        
        let myTable = UITableView(frame: CGRect.zero, style: .insetGrouped)
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return myTable
    }()
    
    var weekData = ["Every Sunday", "Every Monday","Every Tuesday","Every Wednesday", "Every Thrusday", "Every Friday", "Every Saturday"]
    
    var isSelected = [Int]()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .black
        overrideUserInterfaceStyle = .dark
        
        setupUI()
    }
    
    func setupUI(){
        navigationController?.navigationBar.tintColor = .orange
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
        return weekData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = weekData[indexPath.row]
        
        cell.selectionStyle = .none
        
        if isSelected.contains(indexPath.row){
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelected.contains(indexPath.row){
            isSelected = isSelected.filter { $0 != indexPath.row}
        }else{
            isSelected.append(indexPath.row)
        }
        //點選時有動畫
        tableView.reloadRows(at: [indexPath], with: .automatic)
//        tableView.reloadData()
        print(isSelected)
    }
    
}
