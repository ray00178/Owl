//
//  UIAnimationLabel.swift
//  Owl
//
//  Created by Ray on 2021/9/29.
//

import UIKit

/// 仿數字跳動動畫
/// - Reference:
///   - https://zhuanlan.zhihu.com/p/34348398
///   - https://juejin.im/entry/58c0dc25ac502e0062bf1545
class UIAnimationLabel: UILabel {

    /// 起始值，default = 0
    private var startValue: Int = 0
    
    /// 結束值，default = 0
    private var endValue: Int = 0
    
    /// 起始值是否大於結束值，default = false
    private var isGreater: Bool = false
    
    /// 目前顯示的數值，default = 0
    private var currentValue: Int = 0
    
    /// 計算每幀幅的最大值
    private var maxValuePerFrame: Int = 0
    
    /// 進度值，default = 0.0
    private var progress: TimeInterval = 0.0
    
    /// 上一次的時間，default = 0.0
    private var preTime: TimeInterval = 0.0
    
    /// 動畫時間，default = 2.0
    private var animationDuration: TimeInterval = 0.0
    
    private var displayLink: CADisplayLink?
    
    /// 啟動動畫
    /// - Parameters:
    ///   - from: 起始數字
    ///   - to: 結束數字
    ///   - duration: 動畫時間
    ///   - fps: 每秒顯示幾幀幅
    public func animate(from: Int, to: Int, duration: TimeInterval = 1.0, fps: Int = 5) {
        displayLink?.invalidate()
        displayLink = nil
        
        if duration == 0.0 || from == to {
            text = "\(to)"
            return
        }
        
        isGreater = from > to
        startValue = from
        endValue = to
        currentValue = from
        
        progress = 0.0
        animationDuration = duration
        preTime = Date.timeIntervalSinceReferenceDate
        
        displayLink = CADisplayLink(target: self, selector: #selector(update(_:)))
        
        // 每秒顯示幾幀幅，數值越大表示顯示時間間隔後才顯示下一幀幅
        // value = 1，表示 60/1 = 60FPS
        // value = 5，表示 60/5 = 12FPS
        displayLink?.preferredFramesPerSecond = 60 / fps
        
        // 2個數值的差距
        let gap = isGreater ? from - to : to - from
        
        // 計算總共幀幅數
        let frames = 60 / fps
        maxValuePerFrame = gap / frames
        
        // 防止在UIScrollView, UITableView or UICollectionView 拖曳時，導致預料之外影響
        displayLink?.add(to: .main, forMode: .common)
    }
    
    @objc private func update(_ displayLink: CADisplayLink) {
        // 目前該幀幅的時間
        //print("Target targetTimestamp = \(display.targetTimestamp)")
        
        // Setting FPS
        //print("Target preferredFramesPerSecond = \(display.preferredFramesPerSecond)")
        
        let now = Date.timeIntervalSinceReferenceDate
        progress += now - preTime
        preTime = now
        
        if progress >= animationDuration {
            displayLink.isPaused = true
            displayLink.invalidate()
            progress = animationDuration
            text = "\(endValue)"
            return
        }

        if isGreater {
            currentValue -= maxValuePerFrame
        } else {
            currentValue += maxValuePerFrame
        }
        
        text = "\(currentValue)"
    }

}
