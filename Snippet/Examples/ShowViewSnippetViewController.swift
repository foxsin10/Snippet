//
//  UIViewViewController.swift
//  Snippet
//
//  Created by yzjon 2018/2/1.
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



    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View Snippet"
        // Do any additional setup after loading the view.
        congifSomeViews()

        imageView.image = somview.sp.currentshot()
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
            .added(to: view)
            .click {
                [unowned self] in
                if let ges = self.somview.gestureRecognizers {
                    print((ges, #line))
                }
                self.transformSomeView()
            }
            .set(\.backgroundColor, to: .blue)


    }

    private func transformSomeView() {
        somview.sp
            .apply { (v) in
                v.backgroundColor = .orange
            }
            .layout(CGRect.init(x: 20, y: 100, width: 70, height: 70))
            .click {
                [unowned self] in
                guard let ges = self.somview.gestureRecognizers else { return }
                print((ges, #line))
                self.imageView.image = self.somview.sp.currentshot()
        }
    }
}
