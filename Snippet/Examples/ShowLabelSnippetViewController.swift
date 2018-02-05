//
//  UILabelViewController.swift
//  Snippet
//
//  Created by 杨子疆 on 2018/2/1.
//  Copyright © 2018年 yzj. All rights reserved.
//

import UIKit

class ShowLabelSnippetViewController: UIViewController {

    enum SnippetDisplay: Int {
        case labelColor
        case labelFont
        case labelFontAndColor
    }

    private lazy var items: [SnippetDisplay] = [.labelColor, .labelFont, .labelFontAndColor]

    @IBOutlet weak var tableList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Label Snippet"
        // Do any additional setup after loading the view.
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

        if let textLabel = cell.textLabel, let detailLabel = cell.detailTextLabel {
            let item = items[indexPath.row]
            switch item {
            case .labelColor:
                attributeColor(textLabel, detailLabel)
            case .labelFont:
                attributeColor(textLabel, detailLabel)
            case .labelFontAndColor:
                attributeColorAndFont(textLabel, detailLabel)
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

