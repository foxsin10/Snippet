//
//  UIViewViewController.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

class ShowViewSnippetViewController: UIViewController {

    private lazy var somview: UIView = {
        let v = UIView()
        v.backgroundColor = .cyan
        v.frame = CGRect.init(x: 300, y: 200, width: 200, height: 200)
        v.isUserInteractionEnabled = true 
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Button Snippet"
        // Do any additional setup after loading the view.
        congifSomeViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ShowViewSnippetViewController {
    private func congifSomeViews() {
        if let ges = self.somview.gestureRecognizers {
            print(ges)
        }
        somview.sp
            .add(to: view)
            .click {
                [unowned self] in
                print("congifSomeViews")
                if let ges = self.somview.gestureRecognizers {
                    print(ges)
                }
                self.transformSomeView()
        }
    }

    private func transformSomeView() {
        somview.sp
            .apply { (v) in
                v.backgroundColor = .orange
            }
            .layout(CGRect.init(x: 20, y: 100, width: 70, height: 70))
            .click {
                [unowned self] in
                print("transform")
                guard let ges = self.somview.gestureRecognizers else { return }
                print(ges)
        }
    }
}
