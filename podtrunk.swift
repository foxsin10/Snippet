//
//  main.swift
//  Podtrunk
//
//  Created by 杨子疆 on 2018/2/12.
//  Copyright © 2018年 yzj. All rights reserved.
//

import Foundation


// MARK: - 版本
struct VersionInfo {
    let version: String
    let numbers: [String]
    let valid: Bool

    func isSuper(to another: VersionInfo) -> Bool {

        guard numbers.count == another.numbers.count else { return false }

        let n = numbers.compactMap { Int($0) }
        let an = another.numbers.compactMap { Int($0) }
        guard n.count == an.count else { return false }

        var isSuper = false
        for (i,version) in n.enumerated() {

            let ansubVersion = an[i]
            if version > ansubVersion {
                isSuper = true
                break
            }
        }

        return isSuper
    }
}

// MARK: - git
struct Git {

    private var tagInfo: String
    private let gitPath: String

    init(_ tagInfo: String, _ gitPath: String) {
        self.tagInfo = tagInfo
        self.gitPath = gitPath
    }

    @discardableResult
    mutating func checkTags() -> [String] {

        let tags = excute(gitPath, ["tag"])
            .result
            .components(separatedBy: "\n")
            .filter({ $0.count > 1 })


        guard tags.count > 0 else {
            tagInfo = "0.0.1"
            return []
        }

        let lastVersion = tags.last!



        func bumpVersion(_ currentVersion: String) -> String? {
            let numbers = currentVersion.components(separatedBy: ".")
                .compactMap({ Int($0) })
            guard numbers.count == 3 else { return nil }

            var tempNumber = numbers
            var last = tempNumber[2]
            var first = tempNumber[0]
            var second = tempNumber[1]

            last += 1
            if last > 9 {
                last = 0
                second += 1
                if second > 9 {
                    second = 0
                    first += 1
                }
            }

            tempNumber = [first, second, last]

            let r = tempNumber.compactMap({String.init($0)})
                .joined(separator: ".")
            return r

        }

        if let t = bumpVersion(lastVersion) {
            self.tagInfo = t
        } else {
            fatalError("invalid tags")
        }

        return tags
    }



    func tag() {
        excute(gitPath, ["tag", tagInfo])
    }

    func pushTags() {
        excute(gitPath, ["push", "--tags"])
    }
}

// MARK: - pod
struct Pod {

    private let podspec: String
    private let podPath: String

    init(_ podspec: String, _ podPath: String) {
        self.podspec = podspec
        self.podPath = podPath
    }

    func specLint() {
        excute(podPath, ["spec", "lint", podspec])
    }

    func podTrunk() {
        excute(podPath,["trunk", "push", podspec])
    }

}


func validateVersion(_ version: String?) -> VersionInfo {
    guard let v = version else {
        print("empty version format")
        let versonInfo = VersionInfo.init(version: "", numbers: [], valid: false)
        return versonInfo
    }
    guard v.count > 0 else {
        print("empty version format")
        return VersionInfo.init(version: "", numbers: [], valid: false)
    }

    let versions = v.components(separatedBy: ".")
    guard versions.count == 3 else {
        print("invalid version format")
        return VersionInfo.init(version: "", numbers: [], valid: false)
    }

    let t = versions.compactMap { Int($0) }

    guard t.count == 3 else {
        print("invalid version number")
        return VersionInfo.init(version: "", numbers: [], valid: false)
    }

    let info = VersionInfo.init(version: v, numbers: versions, valid: true)
    return info
}

@discardableResult
func excute(_ host: String,
            _ arguments: [String],
            _ shorPath: Bool = true,
            _ needfilter: Bool = false) -> (statusCode: Int32, result: String) {

    var path = "/usr/bin/" + host
    // 不是全路径
    if shorPath {
        path = host
    }


    let task = Process()
    task.launchPath = path
    task.arguments = arguments

    let pipe = Pipe()
    task.standardOutput = pipe


    task.launch()
    task.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()


    var output: String = String(data: data, encoding: .utf8)!
    if needfilter {
        output = output.replacingOccurrences(of: "\n", with: "")
    }

//    print(output)
    return (task.terminationStatus, output)
}

@discardableResult
func pwd() -> String {
    return excute("/usr/bin/",["pwd"]).result
}

@discardableResult
func findCommander(_ commander: String) -> String {
    let host = "which"
    return excute(host, [commander], false, true).result
}

@discardableResult
func excuteShell(_ arguments: [String]) -> (Int32, String) {
    let path = "env"
    return excute(path, arguments, false, true)
}














/******************/
print("start pod trunk \n")


let p = excute("/usr/bin/env",["pwd"], true ,true)

let fileManager = FileManager.default
let files = try! fileManager.contentsOfDirectory(atPath: p.result)
let spec = files.filter({ $0.contains("podspec") })

guard spec.count > 0,spec.count == 1 else {
    fatalError("mutiple spec files exist")
}


let podspec = spec.first!

let podPath = findCommander("pod")
let gitPath = findCommander("git")

var git: Git = .init("", gitPath)
git.checkTags()
git.tag()
git.pushTags()

let pod: Pod = .init(podspec, podPath)
pod.specLint()
pod.podTrunk()









