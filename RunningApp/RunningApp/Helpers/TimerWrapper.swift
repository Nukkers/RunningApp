// Copyright © 2017 BBC. All rights reserved.

import Foundation

public protocol TimerWrapperProtocol {
    func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping () -> Swift.Void)
    func endTimer()
    var fireDate: Date? { get }
    var hasTimer: Bool { get }
}

public class TimerWrapper: TimerWrapperProtocol {
    
    private var timer: Timer?
    
    public init() {
        
    }
    
    public var hasTimer: Bool {
        return timer != nil
    }
    
    public var fireDate: Date? {
        return timer?.fireDate
    }
    
    public func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping () -> Swift.Void) {
        
        endTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats) { [weak self] (_) in
           
            if !repeats {
                guard let strongSelf = self else { return }
                strongSelf.endTimer()
            }
            
            block()
        }
    }
    
    public func endTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
    }
}
