//
//  SwiftStruct.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/25.
//

import Foundation

class SwiftStruct {
    static func memoryLayoutIntroduce() {
        // swift 中自定义结构体变量在内存中是怎么存放的？
        
        struct Point {
            var x = 0, y = 0
        }
        
        var varPointStruct = Point(x: 1, y: 2)
        let constantPointStruct = Point(x: 1, y: 2)
        varPointStruct.x = 2
        
        // 结果说明：
        // 结构体的内存占用大小是把存放到结构体中的变量占用内存大小加起来。
        print("MemoryLayout.stride(ofValue: varPointStruct): \(MemoryLayout.stride(ofValue: varPointStruct))")
        print("MemoryLayout.stride(ofValue: constantPointStruct): \(MemoryLayout.stride(ofValue: constantPointStruct))")
    }
}




