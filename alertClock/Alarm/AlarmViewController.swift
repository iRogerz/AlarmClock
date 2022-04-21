//
//  AlarmViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/15.
//

import UIKit
import SnapKit

class AlarmViewController: UIViewController {

    
    //MARK: - UI
    let alarmTableView:UITableView = {
        let myTable = UITableView()
        myTable.separatorStyle = .singleLine
        return myTable
    }()

    var data = [String]()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
    }
    
    //MARK: - setupUI
    func setupUI(){
        
        alarmTableView.dataSource = self
//        alarmTableView.delegate = self
        self.view.addSubview(alarmTableView)
        alarmTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //MARK: - setup Navegation
    func setupNavigation(){
        navigationItem.title = "鬧鐘"
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
        let addAlarmNC = UINavigationController(rootViewController: AddAlarmViewController())
        present(addAlarmNC, animated: true, completion: nil)
    }
    
}

extension AlarmViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

}
