//
//  ShowTextViewSnippetViewController.swift
//  Snippet
//
//  Created by yzj on 2018/2/7.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

class ShowTextViewSnippetViewController: UIViewController {


    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        showFirstField()
        showSecondField()
        shwoFirstTextView()
        showSecondTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ShowTextViewSnippetViewController {
    private func showFirstField() {
        firstField.sp
            .apply { (v) in
                v.placeholder = "text me plz"
            }
        // 
        firstField.sp.placeholderColor = .cyan
    }

    private func showSecondField() {

        let label = UILabel()
        secondField.sp.apply { (v) in
            v.placeholder = "call me maybe"
        }

        print(secondField.sp.placeholderColor! == label.textColor) // false
        print(secondField.sp.placeholderColor == secondField.textColor) // false
        secondField.sp.placeholderColor = .orange
    }

    private func shwoFirstTextView() {

        firstTextView.sp
            .apply({ (v) in
                v.textColor = .lightGray
                v.tintColor = .lightGray
            })
            .set(placeholder: "call me?", for: .brown)

        let text = firstTextView.sp.placeholder!
        assert(text == "call me?")
    }

    private func showSecondTextView() {

        let text = "shwo some attributedText".sp.attribute(for: "attributedText", with: (.red, UIFont.systemFont(ofSize: 12)))!

        let b = secondTextView.sp.attributedPlaceholder
        assert(b == nil)

        secondTextView.sp
            .apply { (v) in
                v.textColor = .orange
            }
            .set(placeholder: text, for: .cyan)

        let a = secondTextView.sp.attributedPlaceholder!

        assert(text == a)
    }
}
