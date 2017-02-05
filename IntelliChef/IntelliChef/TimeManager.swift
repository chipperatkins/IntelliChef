//
//  TimeManager.swift
//  IntelliChef
//
//  Created by Joey Murphy on 2/5/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class TimerManager {
    
    var realSharedInstance: TimerManager?
    var sharedInstance: TimerManager {
        get{
            if let realSharedInstance = realSharedInstance {
                return realSharedInstance
            }
            else{
                realSharedInstance = TimerManager()
                return realSharedInstance!
            }
        }
    }
    
    var timer: Timer
    var time: Int
    
    @objc func decreaseTimer() {
        if time > 0 {
            time -= 1
        } else {
            timer.invalidate()
        }
    }
    
    init() {
        time = 0
        timer = Timer()
    }
    
    func start(time: Int) {
        self.time = 100
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
    }
    
    func rest() {
        timer = Timer()
    }
}
