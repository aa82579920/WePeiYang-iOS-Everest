//
//  MyLostFoundPageViewController.swift
//  WePeiYang
//
//  Created by JasonEWNL on 2018/10/20.
//  Copyright © 2018年 twtstudio. All rights reserved.
//

import UIKit
import WMPageController

class MyLostFoundPageViewController: WMPageController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        navigationController?.navigationBar.barStyle = .black

        pageAnimatable = true
        menuViewStyle = .line
        titleSizeSelected = 16.0
        titleSizeNormal = 15.0
        menuHeight = 50
        titleColorSelected = UIColor(hex6: 0x00a1e9)
        titleColorNormal = UIColor(hex6: 0xc8ccd3)
        menuItemWidth = self.view.frame.size.width/2
        menuBGColor = .white
        progressColor = UIColor(hex6: 0x00a1e9)
        
        self.viewControllerClasses = [MyLostViewController.self, MyFoundViewController.self]
        self.titles = ["我丢失的", "我捡到的"]
    }
    
}
