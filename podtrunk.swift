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

// MARK: - git
struct Git {

    private let tagInfo: String
    private let gitPath: String

    init(_ tagInfo: String, _ gitPath: String) {
        self.tagInfo = tagInfo
        self.gitPath = gitPath
    }

    func checkTags() -> [String] {

        return  excute(gitPath, ["tag"])
            .result
            .components(separatedBy: "")
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

    let t = versions.flatMap { Int($0) }

    guard t.count == 3 else {
        print("invalid version number")
        return VersionInfo.init(version: "", numbers: [], valid: false)
    }

    let info = VersionInfo.init(version: v, numbers: versions, valid: true)
    return info
}

@discardableResult
func excute(_ host: String, _ arguments: [String], _ shorPath: Bool = true) -> (statusCode: Int32, result: String) {

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
    output = output.replacingOccurrences(of: "\n", with: "")

    return (task.terminationStatus, output)
}

@discardableResult
func pwd() -> String {
    return excute("/usr/bin/",["pwd"]).result
}

@discardableResult
func findCommander(_ commander: String) -> String {
    let host = "which"
    return excute(host, [commander], false).result
}

@discardableResult
func excuteShell(_ arguments: [String]) -> (Int32, String) {
    let path = "env"
    return excute(path, arguments, false)
}


//let p = excute("/usr/bin/env",["pwd"])

//print(p)
//let fileManager = FileManager.default
//let a = try! fileManager.contentsOfDirectory(atPath: p)
//print(a)





/******************/
print("input version, podSpecfile:")

guard let inputInfo = readLine() else {
    print("invalid input info")
    exit(0)
}

let argus = inputInfo.components(separatedBy: " ")

guard argus.count == 2 else {
    print("invalid input info")
    exit(0)
}

let info = validateVersion(argus[0])
guard info.valid == true else {
    print("invalid version parse")
    exit(0)
}




var podspec = argus[1]
podspec += ".podspec"
let podPath = findCommander("pod")

let gitPath = findCommander("git")

let git: Git = .init(info.version, gitPath)

let pod: Pod = .init(podspec, podPath)

git.tag()
git.pushTags()

pod.specLint()
pod.podTrunk()












