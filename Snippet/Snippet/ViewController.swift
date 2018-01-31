//
//  ViewController.swift
//  Snippet
//
//  Created by yzj on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

         _ = UILabel()
            .sp.layout(CGRect.init(x: 20, y: 40, width: 100, height: 40))
            .add(to: view)
            .customSet({ (v) in
                v.font = UIFont.systemFont(ofSize: 12)
                v.textColor = .orange
            })
            .attribute("aaddeent", for: "ee", with: .red)
        view.sp.customSet { (v) in
            v.backgroundColor = .white
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

