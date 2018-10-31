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
    func testString() {
        let astring = "adssk"
        let aIndex = astring.index(of: "a")
        let dIndex = astring.index(of: "d")
        guard let location = dIndex?.encodedOffset else { return }
        let ocString = astring as NSString
        let range = ocString.range(of: "d")
        let swiftRange = NSRange.init(location: location, length: 1)
        print(range)
        print("---")
        print(swiftRange)
        assert( swiftRange == range )
    }

    func testViewClick() {
        let v = UIView()
        v.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
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
        let elemntButes: [NSAttributedString.Key: Any] = [
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

    func testGroup() {

        let details: [ProcessDetail] = [
            ProcessDetail.init(enKey: "22", showKey: "33333", showValue: "5adada"),
            ProcessDetail.init(enKey: "2452", showKey: "2313", showValue: "sdaiuqeq")
        ]
        let models: [ProcessValue<String, [ProcessDetail]>] = [
            .stringValue("sssss"),
            .arrayValue(details)
        ]

        let data = try! JSONEncoder().encode(models)
        let json = String.init(data: data, encoding: .utf8)!
        print(json)

        let decoded = try! JSONDecoder().decode([ProcessValue<String, [ProcessDetail]>].self, from: data)
        print("--------")
        print(decoded)
    }

    func testEnumCodable() {
        let json = """
             [{
                "value": [
                    {
                        "enKey": "tabShow",
                        "showKey": "本人信息",
                        "showValue": "personal_details"
                    }
                ]
            },
            {
                "value": "ssssss"
            },{
                "value": null
            }]
        """

        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder.init()

        do {
            let result = try decoder.decode([TestModel].self, from: data)

            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(result)
                let s = String.init(data: data, encoding: .utf8)!
                print("en")
                print(s)
            } catch (let e) {
                print("en")
                print(e)
            }

            print("---")
            print(result)
        } catch(let e) {
            print(e)
        }
    }
}


struct TestModel: Codable {
    var value: ProcessValue<String, [ProcessDetail]>?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let string = try? container.decode(String.self, forKey: .value) {
            value = .stringValue(string)
        } else if let array = try? container.decode([ProcessDetail].self, forKey: .value) {
            value = .arrayValue(array)
        } else {
            value = nil
        }

    }
}

struct ProcessDetail: Codable {
    var enKey: String?
    var showKey: String?
    var showValue: String?
}

enum ProcessValue<A: Codable, B: Codable> {

    case stringValue(A?)
    case arrayValue(B?)
}

extension ProcessValue: CustomStringConvertible {
    var description: String {
        switch self {
        case .arrayValue(let b):
            guard let s = b else {
                return "array: [] \n"
            }
            return "array: \(s) \n"
        case .stringValue(let a):
            guard let s = a else {
                return "string: nil \n"
            }
            return "string: \(s)"
        }
    }
}

extension ProcessValue: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        do {
            let leftValue =  try container.decode(A.self, forKey: .stringValue)
            self = .stringValue(leftValue)
        } catch (let e) {
            print(e)
            let rightValue =  try container.decode(B.self, forKey: .arrayValue)
            self = .arrayValue(rightValue)
        }

    }
}

extension ProcessValue: Encodable {
    enum CodingKeys: CodingKey {
        case stringValue
        case arrayValue
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .stringValue(let value):
            try container.encode(value, forKey: .stringValue)
        case .arrayValue(let value):
            try container.encode(value, forKey: .arrayValue)
        }
    }
}
