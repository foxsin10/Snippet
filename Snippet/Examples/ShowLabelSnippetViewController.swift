//
//  UILabelViewController.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

class ShowLabelSnippetViewController: UIViewController {


    private lazy var items: [(UILabel, UILabel) -> Void] = []

    @IBOutlet weak var tableList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Label Snippet"
        // Do any additional setup after loading the view.

        // fuctions
        items = [attributeColor,
                 attributeFont,
                 attributeColorAndFont]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ShowLabelSnippetViewController {
    private func attributeColor(_ title: UILabel, _ detail: UILabel) {
        title.text = "Color"

        detail.sp.attribute("see hehe string", for: "hehe", with: .orange)
    }

    private func attributeFont(_ title: UILabel, _ detail: UILabel) {
        title.text = "Font"

        var font = detail.font
        font = UIFont.systemFont(ofSize: font!.pointSize + 1)
        detail.sp.attribute("see hehe string", for: "hehe", with: (detail.textColor, font!))
    }

    private func attributeColorAndFont(_ title: UILabel, _ detail: UILabel) {
        title.text = "Color and Font"

        var font = detail.font
        font = UIFont.systemFont(ofSize: font!.pointSize + 1)
        detail.sp.attribute("see hehe string", for: "hehe", with: (.orange, font!))
    }
}

extension ShowLabelSnippetViewController: UITableViewDelegate {}

extension ShowLabelSnippetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let textLabel = cell.textLabel, let detailLabel = cell.detailTextLabel else { return cell }

        let item = items[indexPath.row]
        item(textLabel, detailLabel)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

