//
//  SwiftArray.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/25.
//

import Foundation

class SwiftArray {
    static func memoryLayoutIntroduce() {
        // swift 中 array 变量在内存中是怎么存放的？
        // array 是 struct（值类型）
        // 总结：数组的表象是结构体，但其本质是引用类型。
        
        var varArray = [1, 2, 3, 4]
        let constantArray = [1, 2, 3, 4]
        varArray[0] = 2
        
        print("MemoryLayout.stride(ofValue: varArray): \(MemoryLayout.stride(ofValue: varArray))")
        print("MemoryLayout.stride(ofValue: constantArray): \(MemoryLayout.stride(ofValue: constantArray))")
        
        //MemsUsage().showMemsUsage()
        
        // 通过汇编分析可以知道，数组中数组是存放在堆空间的，数组变量内存存放着堆空间的数组对象地址。
        // 通过内存布局看到，数组内容需要跳过前面的32个字节。那么前面的字节分别存放着什么东西呢？
        //
        // 第一段8个字节：存放着数组相关引用类型信息内存地址
        // 第二段8个字节：数组的引用计数
        // 第三段8个字节：数组的元素个数
        // 第四段8个字节：数组的容量
        // 后面依次存放着数组的元素
        print("Mems.memStr(ofRef: varArray): \n\(Mems.memStr(ofRef: varArray))")
        
        varArray.append(5)
        print("Mems.memStr(ofRef: varArray): \n\(Mems.memStr(ofRef: varArray))")
        
        varArray.append(6)
        varArray.append(7)
        varArray.append(8)
        varArray.append(9)
        print("Mems.memStr(ofRef: varArray): \n\(Mems.memStr(ofRef: varArray))")
    }
}




