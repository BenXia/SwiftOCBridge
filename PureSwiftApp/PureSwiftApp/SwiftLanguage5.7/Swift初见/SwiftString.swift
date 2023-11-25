//
//  SwiftString.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/25.
//

import Foundation

extension String {
    subscript(index: Int) -> Character {
        guard let index = self.index(startIndex, offsetBy: index, limitedBy: endIndex) else {
            fatalError("String index out of range")
        }
        
        return self[index]
    }
}

class SwiftString {
    static func characterSetIntroduce() {
        // 预备知识：
        // 字符三层编码
        // 字符集及码元
        // 单个编码码元大小
        // 定长或变长码元 <-> 码元的映射规则
        
        // String 不要理解成一个集合类型，可以理解成提供了从多个维度展现unicode视图的类型
        // UTF-8 View、UTF-16 View、Scalar View、Character collections（即直接操作 string 本身）
        // Character collections（即直接操作 string 本身）: 跟人看到的符号的个数语义一样（多个合成一个符号的也理解成一个）
        // Scalar View: 21位Unicode码元值为单位操作
        // UTF-8 View: 以 utf8 编码的单个码元为单位操作
        // UTF-16 View: 以 utf16 编码的单个码元为单位操作（跟 NSString 操作的意义相同）
        
        // String.count 与 NSString.length 的差异
        // NSString.length 与 NSString.data(using:.utf8).count 的差异
        let string: String = "👩‍👩‍👦‍👦"
        // string.count 是人看到的符号的个数
        print("string count: \(string.count)")
        print("string.utf16: \(string.utf16)")
        print("string.utf16.count: \(string.utf16.count)")
        print("string.utf8.count: \(string.utf8.count)")
        
        let nsstring: NSString = "👩‍👩‍👦‍👦"
        // nsstring.length 是 utf16 编码占用的码元个数
        print("nsstring length: \(nsstring.length)")
        print("nsstring data length: \(String(describing: nsstring.data(using: String.Encoding.utf8.rawValue)?.count))")
        
        
        
        // UnicodeScalar: 21位Unicode码元值
        var str = String(UnicodeScalar(99))
        let ch = Character(UnicodeScalar(UInt8(100)))
        
        str.append(ch)
        print("str.unicodeScalars.first?.value == 99 : \(str.unicodeScalars.first?.value == 99)")
        print("ch.unicodeScalars.first : \(String(describing: ch.unicodeScalars.first ?? UnicodeScalar(0)))")
        
        
        // 直接对 string 的各种操作都是按照人看到的符号形式理解
        let swift = "Swift is fun"
        let swiftDroped: Substring = swift.dropFirst(9)
        print("swift: \(swift)")
        print("swift droped: \(swiftDroped)")

        let group = "👩‍👩‍👦‍👦"
        let groupDroped: Substring = group.dropFirst(1)
        print("group: \(group)")
        print("group droped: \(groupDroped)")
        
        let cafeeStr = "caf\u{0065}\u{0301}"
        let cafeeStrDropedFirst4: Substring = cafeeStr.dropFirst(4)
        let cafeeStrDropedLast = cafeeStr.dropLast()
        print("cafeeStrDropedFirst4: \(cafeeStrDropedFirst4)")
        print("cafeeStrDropedLast: \(cafeeStrDropedLast)")
        
        cafeeStr.unicodeScalars.forEach { print($0) }
        cafeeStr.utf8.forEach { print($0) }
        cafeeStr.utf16.forEach { print($0) }

        
        let cafeeStrUnicodeScalarsDropLast: Substring.UnicodeScalarView = cafeeStr.unicodeScalars.dropLast()
        cafeeStrUnicodeScalarsDropLast.forEach { print($0) }
        // 转换回 String, 不会有失败的情况
        let convertUnicodeScalarsToString = String(cafeeStrUnicodeScalarsDropLast)
        print("convertUnicodeScalarsToString: \(convertUnicodeScalarsToString)")
        
        let cafeeStrUTF8DropLast: Substring.UTF8View = cafeeStr.utf8.dropLast()
        cafeeStrUTF8DropLast.forEach{ print($0) }
        // 转换回 String 类型失败
        let convertUTF8ToString = String(cafeeStrUTF8DropLast)
        print("convertUTF8ToString: \(convertUTF8ToString ?? "")")
        
        let cafeeStrUTF16DropLast: Substring.UTF16View = cafeeStr.utf16.dropLast()
        cafeeStrUTF16DropLast.forEach{ print($0) }
        // 转换回 String 类型成功
        let convertUTF16ToString = String(cafeeStrUTF16DropLast)
        print("convertUTF16ToString: \(convertUTF16ToString ?? "")")
        
        

        //cafeeStr.characters
        //cafeeStr.characters.count

        //// String.Character.Index
        //cafeeStr.characters.startIndex
        //cafeeStr.characters.endIndex
        //// cafeeStr.characters[2] 错误用法

        
        
        // 1. Get character index（人看到的符号形式）
        // O(n)
        //let idx = cafeeStr.index(cafeeStr.startIndex, offsetBy: 3)
        let idx = cafeeStr.index(cafeeStr.startIndex, offsetBy: 3, limitedBy: cafeeStr.endIndex)
        // 2. Subscript access
        print("cafeeStr[idx!]: \(cafeeStr[idx!])")


        // 测试 extension
        print("cafeeStr[3] using extension: \(cafeeStr[3])")

        for i in 0..<4 {
            print(cafeeStr[i])  // 0(n^2)
        }
        
        
        // canonical equivalence
        // 这两种形式并不是等价的，因为包含不同的code point，
        // 却是canonically equivalent:即它们有相同的形态（按道理是看起来应该是一样的，但实际是不是一样就得问上帝了）和意思。
        let eAcute: Character = "\u{E9}"                         // é
        // é U00e9 "LATIN SMALL LETTER E WITH ACUTE"
        let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上 ‘
        // e U0065 "LATIN SMALL LETTER E"
        // ‘ U0301 "COMBINING ACUTE ACCENT"
        print("eAcute.count: \(String(eAcute).count)")
        print("combinedEAcute.count: \(String(combinedEAcute).count)")
        print("eAcute.unicodeScalars.count: \(eAcute.unicodeScalars.count)")
        print("combinedEAcute.unicodeScalars.count: \(combinedEAcute.unicodeScalars.count)")

        let sOne = String(eAcute)
        let sTwo = String(combinedEAcute)
        print("sOne.count: \(sOne.count)")
        print("sTwo.count: \(sTwo.count)")
        print("sOne.utf8.count: \(sOne.utf8.count)")
        print("sTwo.utf8.count: \(sTwo.utf8.count)")
        print("sOne.utf16.count: \(sOne.utf16.count)")
        print("sTwo.utf16.count: \(sTwo.utf16.count)")
        print("sOne == sTwo: \(sOne == sTwo)")
        print("sOne.isEqual(sTwo): \(sOne.isEqual(sTwo))")
        print("sOne.decomposedStringWithCanonicalMapping.isEqual(sTwo.decomposedStringWithCanonicalMapping): \(sOne.decomposedStringWithCanonicalMapping.isEqual(sTwo.decomposedStringWithCanonicalMapping))")

        
        let nsOne = NSString(string: sOne)
        let nsTwo = NSString(string: sTwo)
        print("nsOne == nsTwo: \(nsOne == nsTwo)")
        print("nsOne.isEqual(to: nsTwo as String): \(nsOne.isEqual(to: nsTwo as String))")
        print("nsOne.decomposedStringWithCanonicalMapping.isEqual(nsTwo.decomposedStringWithCanonicalMapping): \(nsOne.decomposedStringWithCanonicalMapping.isEqual(nsTwo.decomposedStringWithCanonicalMapping))")

        
        let result = nsOne.compare(nsTwo as String)
        print("nsOne.compare(nsTwo as String) == .orderedSame: \(result == .orderedSame)")


        let circleSOne = sOne + "\u{20dd}"
        print("circleSOne.count: \(circleSOne.count)")

        print("\"👩‍🦰\".count: \("👩‍🦰".count)")
        print("\"👩‍👩‍👦‍👦\".count: \("👩‍👩‍👦‍👦".count)")
        print(#""👩\u{200d}👩\u{200d}👦\u{200d}👦" == "👩‍👩‍👦‍👦": \#("👩\u{200d}👩\u{200d}👦\u{200d}👦" == "👩‍👩‍👦‍👦")"#)


        // compatibility equivalence
        // 很多字符和序列则在广义上是重复的，在Unicode标准中称为 compatibility equivalence ，兼容序列代表相同的抽象字符，但可能没有相同的视觉体现或者行为。比如很多希腊字母，同时也用于数学了技术符号。罗马数字在标准拉丁字母之外额外编码在U+2160到 U+2183间。其它的兼容相等的例子是 ligatures：字符ﬀ (LATIN SMALL LIGATURE FF, U+FB00) 与序列 ff (LATIN SMALL LETTER F + LATIN SMALL LETTER F, U+0066 U+0066)兼容，但不是canonically equivalent，虽然它们可能渲染得完全一样，但取决于不同的上下文，typeface及文本渲染系统的能力。
        let strOne = "\u{FB00}"
        let strTwo = "\u{0066}\u{0066}"
        print("strOne.isEqual(strTwo): \(strOne.isEqual(strTwo))")
        print("strOne.decomposedStringWithCompatibilityMapping.isEqual(strTwo.decomposedStringWithCompatibilityMapping): \(strOne.decomposedStringWithCompatibilityMapping.isEqual(strTwo.decomposedStringWithCompatibilityMapping))")



        // 常见的 String 字符串操作
        let cafee = "caf\u{0065}\u{0301}"

        let beg = cafee.startIndex
        let end = cafee.index(beg, offsetBy: 3)
        print("cafee[beg ..< end]: \(cafee[beg ..< end])")

        // 不能写成 cafee[0 ..< 3]
        //String(cafee.characters.prefix(3))
        print("String(cafee.prefix(3)): \(String(cafee.prefix(3)))")

        var mixStr = "Swift很有趣"
        //for (index, value) in mixStr.characters.enumerated() {
        for (index, value) in mixStr.enumerated() {
            print("\(index) \(value)")
        }

        if let index = mixStr.firstIndex(of: "很") {
            mixStr.insert(contentsOf: " 3.0", at: index)
            print("mixStr after insert: \(mixStr)")
        }

        if let cnIndex = mixStr.firstIndex(of: "很") {
            mixStr.replaceSubrange(cnIndex ..< mixStr.endIndex, with: " is interesting!")
            print("mixStr after replace: \(mixStr)")
        }

        print("String(mixStr.suffix(12).dropLast()): \(String(mixStr.suffix(12).dropLast()))")

        print("mixStr.split(separator: \" \").map(String.init): \(mixStr.split(separator: " ").map(String.init))")

        var i = 0

        let resultAfterSplit = mixStr.split { _ in
            if i > 0 {
                i = 0
                return true
            } else {
                i += 1
                return false
            }
        }.map(String.init)
        print("resultAfterSplit: \(resultAfterSplit)")
    }
    
    static func memoryLayoutIntroduce() {
        //swift 中 string 变量在内存中是怎么存放的？
        //总结：
        //字符串长度不超过15位，内容直接放到变量内存中
        //长度超过15位，字符串内容存放在常量区
        //内存中的后8个字节存放的是字符串内容真实存放的内存地址
        //前8个字节存放的是字符串长度及标识符（标识符用来标记字符串存放到哪个区域）
        //只要长度超过15位拼接字符串，都会重新开辟堆空间存放字符串内容。
        
        // 工具栏 Debug->Debug Workflow->Always Show Disassembly 可以查看断点处的汇编代码
        //栈调试技巧（lldb中汇编操作符，左边是目标地址，跟 https://zhuanlan.zhihu.com/p/372748418 这个文章中不一样）
        //函数返回时会恢复到调用者栈帧（函数返回值一般通过 rax/eax（有时候 rax/eax 加上 rbx/ebx) 寄存器保存）
        //po ((Sark *)0x16f5b7d20).name  地址中值强转
        //po *((id *)0x7ff7b0e356a8)
        //po *((char **)0x7ff7b0e356a0)
        //info registers  打印所有寄存器中的值(gdb)
        //register read   打印所有寄存器中的值(lldb)
        //po $esi   打印寄存器中的值(gdb)
        //x $eax    显示寄存器指向的值(gdb)
        //memory read 0x0000000109c16ca8 打印寄存器中的值(lldb)
        var shortStr = "0123456789"
        print(shortStr)
        print("MemoryLayout.size(ofValue: shortStr): \(MemoryLayout.size(ofValue: shortStr))")
        print("MemoryLayout.stride(ofValue: shortStr): \(MemoryLayout.stride(ofValue: shortStr))")
        
        print(Mems.ptr(ofVal: &shortStr))
        print(Mems.memStr(ofVal: &shortStr))
        
        // 打印的 0x3736353433323130 0xea00000000003938
        // 其中 0xea 代表什么意思？
        // 这里应该分开来看，0xea，
        // 后面的一位a代表字符串长度（即长度是10)(那也就意味着字符串长度最大是f，这样就能完整的填满内存。)
        // 前面的e代表字符串标识（e代表字符串内存存储在变量里面的，0则代表字符串内存存储在堆里面，高8位存放指针的指针，此位置不会出现e）。

        var len15Str = "0123456789ABCDE"
        print(Mems.ptr(ofVal: &len15Str))
        print(Mems.memStr(ofVal: &len15Str))
        
        // 超过15个字节，这次输出明显和之前的不一样。
        // 即使长度继续加大，内存变化也不大，这也意味着字符串确实没有存储在这16个字节内。
        var len16Str = "0123456789ABCDEF"
        print(MemoryLayout.size(ofValue: len16Str))
        print(Mems.ptr(ofVal: &len16Str))
        print(Mems.memStr(ofVal: &len16Str))
        
        
        var len18Str = "0123456789ABCDEFGH"
        print(MemoryLayout.size(ofValue: len18Str))
        print(Mems.ptr(ofVal: &len18Str))
        print(Mems.memStr(ofVal: &len18Str))
    }
}



