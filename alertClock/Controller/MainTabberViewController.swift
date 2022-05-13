//
//  MainTabberViewController.swift
//  alertClock
//
//  Created by 曾子庭 on 2022/4/15.
//

import UIKit
import SnapKit
import AudioToolbox


class MainTabberViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    
    func setupTabbar(){
        
        let worldClockNC = UINavigationController(rootViewController: WorldClockViewController())
        let alarmNC = UINavigationController(rootViewController: AlarmViewController())
        let stopWatchNC = UINavigationController(rootViewController: StopWatchViewController())
        let timerNC = UINavigationController(rootViewController: TimerViewController())
        
        //設定tabbar上的文字
        worldClockNC.tabBarItem.image = UIImage(systemName: "network")
        alarmNC.tabBarItem.image = UIImage(systemName: "alarm.fill")
        stopWatchNC.tabBarItem.image = UIImage(systemName: "stopwatch.fill")
        timerNC.tabBarItem.image = UIImage(systemName: "timer")
        
        //設定tabber上的文字
        worldClockNC.title = "World Clock"
        alarmNC.title = "Alarm"
        stopWatchNC.title = "Stopwatch"
        timerNC.title = "Timer"
        
        
        self.tabBar.barTintColor = .clear
        self.tabBar.tintColor = .orange
        
        setViewControllers([worldClockNC, alarmNC, stopWatchNC, timerNC], animated: false)
        
        
        //設定大title文字
        alarmNC.navigationBar.prefersLargeTitles = true
        alarmNC.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         .font: UIFont.boldSystemFont(ofSize: 34)]
    }
    
}
