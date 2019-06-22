//
//  FirstViewController.swift
//  CustomTabBar
//
//  Created by David Anderson on 2019-06-20.
//  Copyright © 2019 Robots & Pencils Inc. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Note: Setting the tab bar item here is too late
        title = tabBarItem.title ?? NSLocalizedString("First", comment: "first")
    }

    override func viewDidLayoutSubviews() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGray6
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
    }
    
    private func commonInit() {
        tabBarItem = UITabBarItem(title: NSLocalizedString("FirstItem", comment: "first"), image: UIImage(named: "first"), tag: 0)
    }
    
}

