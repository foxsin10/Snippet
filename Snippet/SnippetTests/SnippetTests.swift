//
//  SnippetTests.swift
//  SnippetTests
//
//  Created by 杨子疆 on 2018/1/31.
//  Copyright © 2018年 yzj. All rights reserved.
//

import XCTest
@testable import Snippet

class SnippetTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}


extension SnippetTests {

    func testViewClick() {
        let v = UIView()

        assert( v.gestureRecognizers == nil, "ops, invalid count")

        v.sp.click {
            print("dad")
        }

        assert(v.gestureRecognizers!.count == 1, "ops, count overflow")
        v.sp.click {
            print("test")
        }
         assert(v.gestureRecognizers!.count == 1, "ops, count overflow again")
    }

    func testLabelAttribute() {

        let targetString = "some test for AttributedText"
        let element = "AttributedText"

        let label = UILabel()
        label.sp
            .apply({ (v) in
                v.font = UIFont.systemFont(ofSize: 11)
                v.textColor = .orange
            })
            .attribute(targetString, for: element, with: .purple)

        let baseNString = targetString as NSString
        let elementRange = baseNString.range(of: element)
        let attributeString: NSMutableAttributedString = .init(string: targetString)
        let elemntButes: [NSAttributedStringKey: Any] = [
            .font : label.font,
            .foregroundColor : UIColor.purple
        ]

        attributeString.addAttributes(elemntButes, range: elementRange)

        var labelAttributedText: NSMutableAttributedString = NSMutableAttributedString.init(string: "")

        if let t = label.attributedText {
            labelAttributedText = NSMutableAttributedString.init(attributedString: t)
        }

        assert(labelAttributedText == attributeString, "judge AttibutedText failed")

    }
}
