//
//  ViewController.swift
//  TimerSample
//
//  Created by Masuhara on 2019/05/31.
//  Copyright © 2019 Ylab.inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var modeSelectSegment: UISegmentedControl!
    
    @IBOutlet var timeCountLabel: UILabel!
    
    var timer: Timer?
    
    var count: Double = 0.00
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // モード選択を初期化
        modeSelectSegment.selectedSegmentIndex = 0
        
        // 表示を初期化
        clear()
    }
    
    @IBAction func start() {
        // 起動中のタイマーを無効化
        timer?.invalidate()
        
        // タイマーを新規作成(0.01秒ごとに in 以降の処理を発動)
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            
            // モードによって場合分け
            if self.modeSelectSegment.selectedSegmentIndex == 0 {
                self.count = self.count + 0.01
            } else {
                self.count = self.count - 0.01
            }
            
            // タイマーはバックグラウンドスレッドで動いているが、UIの更新はメインスレッドでしか動かせないので、DispatchQueue.mainでメインスレッドを取得し、メインスレッド内でラベルの表示を更新
            DispatchQueue.main.async {
                self.timeCountLabel.text = String(format: "%.2f", self.count)
            }
        }
    }
    
    @IBAction func stop() {
        // 起動中のタイマーを無効化(ただし、count変数の中身とラベルの表示はそのまま)
        timer?.invalidate()
    }
    
    @IBAction func clear() {
        // 起動中のタイマーを無効化し、count変数とラベルの表示を初期化
        timer?.invalidate()
        count = 0.00
        self.timeCountLabel.text = String(format: "%.2f", self.count)
    }
    
    
}

