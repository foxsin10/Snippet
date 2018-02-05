//
//  UIButtonViewController.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

class ShowButtonSnippetViewController: UIViewController {

    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!

    private var scale: CGFloat = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "View Snippet"
        // Do any additional setup after loading the view.

        firstButton.sp
            .attribute("first button", for: "button", with: .red)
            .onClick {
                [unowned self] in
                self.firstButton.sp.attribute("first button", for: "first", with: .orange)
        }

        let font = UIFont.systemFont(ofSize: 16)
        secondButton.sp
            .attribute("seconde button", for: "button", with: (.gray, font))

        thirdButton.sp
            .link(UIControlEvents.touchUpInside) {
                [weak self] in
                UIView.animate(withDuration: 0.2, animations: {
                    self?.scale += 0.1
                    self?.thirdButton.transform = CGAffineTransform.init(scaleX: self!.scale, y: self!.scale)
                })

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
