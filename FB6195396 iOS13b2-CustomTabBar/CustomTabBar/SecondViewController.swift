//
//  SecondViewController.swift
//  CustomTabBar
//
//  Created by David Anderson on 2019-06-20.
//  Copyright © 2019 Robots & Pencils Inc. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        tabBarItem = UITabBarItem(title: NSLocalizedString("SecondItem", comment: "second"), image: UIImage(named: "second"), tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = tabBarItem.title ?? NSLocalizedString("Second", comment: "second")
    }

    override func viewDidLayoutSubviews() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGray6
        } else {
            // Fallback on earlier versions
            view.backgroundColor = .white
        }
    }
}

