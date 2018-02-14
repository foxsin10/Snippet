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

        let n = numbers.flatMap { Int($0) }
        let an = another.numbers.flatMap { Int($0) }
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

protocol ExcutableCommand {
    var path: String { get }
    var arguments: [String] { get set }

    func excute()
}

extension ExcutableCommand {
    func excute() {

        let task = Process()
        task.launchPath = path
        task.arguments = arguments

        task.launch()
        task.waitUntilExit()
    }
}


// MARK: - git
struct Git: ExcutableCommand {
    private let gitpath: String = "/usr/bin/git"
    var arguments: [String]
    var path: String {
        return gitpath
    }
    init(_ argument: [String]) {
        self.arguments = argument
    }
}

// MARK: - pod
struct Pod: ExcutableCommand {
    private var podPath: String
    var path: String {
        return podPath
    }
    var arguments: [String]
    init(_ podPath: String, arguments: [String]) {
        self.podPath = podPath
        self.arguments = arguments
    }
}

// MARK: - shell
struct Shell {
    var type: String
    var arguments: [String]

    func excute()  {

        var path = "/bin"
        path += "/"
        path += type

        let task = Process()
        task.launchPath = path
        task.arguments = arguments

        task.launch()
        task.waitUntilExit()
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

    let t = versions.flatMap { Int($0) }

    guard t.count == 3 else {
        print("invalid version number")
        return VersionInfo.init(version: "", numbers: [], valid: false)
    }

    let info = VersionInfo.init(version: v, numbers: versions, valid: true)
    return info
}

print("input version, podPath, podSpecfile:")

guard let inputInfo = readLine() else {
    print("invalid input info")
    exit(0)
}

let argus = inputInfo.components(separatedBy: " ")

guard argus.count == 3 else {
    print("invalid input info")
    exit(0)
}

let info = validateVersion(argus[0])
guard info.valid == true else {
    print("invalid version parse")
    exit(0)
}

let gitTag: Git = .init(["tag", info.version])
gitTag.excute()

let gitPushTag: Git = .init(["push", "--tags"])
gitPushTag.excute()


let path = argus[1]

var podspec = argus[2]
podspec += ".podspec"

let podLint: Pod = .init(path, arguments: ["spec", "lint", podspec])
podLint.excute()

let podPush: Pod = .init(path, arguments: ["trunk", "push", podspec])
podPush.excute()









