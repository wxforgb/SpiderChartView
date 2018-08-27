//
//  ViewController.swift
//  SpiderChartView
//
//  Created by 王 きん on 2018/08/27.
//  Copyright © 2018年 wx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spiderChartView: SpiderChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        spiderChartView.create(ratingAxisValues: [
            ("コスパ", 0.5),
            ("持続力", 0.5),
            ("カバー力", 0.7),
            ("保湿力", 0.72),
            ("フィット感", 0.7),
            ("UV効果", 0.7)])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

