//
//  timerList.swift
//  Timer
//
//  Created by Зайнал Гереев on 02.09.2021.
//

import UIKit

class MyTimer {
    var name: String
    var time: Int
    var timeLabel: String
    var timer = Timer()
    var index: Int
    var viewController = ViewController()
    
    func formatTime(time: Int) -> String {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        
        return "\(hours):\(minutes):\(seconds)"
    }
    
    init(name: String, time: Int, index: Int, viewController: ViewController) {
        self.name = name
        self.time = time
        self.timeLabel = ""
        self.index = index
        self.viewController = viewController
        self.timeLabel = formatTime(time: time)
        
        timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(1),
            target: self,
            selector: #selector(MyTimer.timerAction),
            userInfo: nil,
            repeats: true
        )
    }
    @objc func timerAction(){
        if self.time == 0 {
            timer.invalidate()
            viewController.timerList.remove(at: index)
            viewController.tableView.reloadData()
            
        } else {
            // 3661 = 1 hour 1 minute 1 second
            self.time -= 1
            self.timeLabel = formatTime(time: time)
            viewController.updateRow(index: self.index)
        }
        
    }
    
    
}
