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
        //           字母 é 可以用单一的 Unicode 标量 é【LATIN SMALL LETTER E WITH ACUTE, 或者 U+00E9】来表示。
        //           然而一个标准的字母 e(LATIN SMALL LETTER E 或者 U+0065)加上一个急促重音（COMBINING ACTUE ACCENT）的标量（U+0301），这样一对标量就表示了同样的字母 é。
        //           在这两种情况中，字母 é 代表了一个单一的 Swift 的 Character 值，
        //           同时代表了一个可扩展的字形群。在第一种情况，这个字形群包含一个单一标量；
        //           而在第二种情况，它是包含两个标量的字形群。
        //
        // Scalar View: 21位Unicode码元值为单位操作（即以 utf32 编码的单个码元为单位操作）
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
        ///

        
        // 可扩展的字形集是一个将许多复杂的脚本字符表示为单个字符值的灵活方式。
        // 例如，字母 é 可以用单一的 Unicode 标量 é【LATIN SMALL LETTER E WITH ACUTE, 或者 U+00E9】来表示。
        //      然而一个标准的字母 e(LATIN SMALL LETTER E 或者 U+0065)加上一个急促重音（COMBINING ACTUE ACCENT）的标量（U+0301），这样一对标量就表示了同样的字母 é。
        let eAcuteCh: Character = "\u{E9}"                         // é
        let combinedEAcuteCh: Character = "\u{65}\u{301}"          // e 后面加上
        // eAcuteCh 是 é, combinedEAcuteCh 是 é
        print("eAcuteCh: \(eAcuteCh)")
        print("combinedEAcuteCh: \(combinedEAcuteCh)")
        
        
        // 例如，来自朝鲜语字母表的韩语音节能表示为组合或分解的有序排列。
        // 在 Swift 都会表示为同一个单一的 Character 值
        let precomposed: Character = "\u{D55C}"                  // 한
        let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
        // precomposed 是 한, decomposed 是 한
        print("precomposed: \(precomposed)")
        print("decomposed: \(decomposed)")
        
        
        // 可拓展的字符群集可以使包围记号（例如 COMBINING ENCLOSING CIRCLE 或者 U+20DD）的标量包围其他 Unicode 标量，作为一个单一的 Character 值：
        let enclosedEAcute: Character = "\u{E9}\u{20DD}"
        // enclosedEAcute 是 é⃝
        print("enclosedEAcute: \(enclosedEAcute)")
        print("String(eAcuteCh) == String(enclosedEAcute): \(String(eAcuteCh) == String(enclosedEAcute))")
        
        
        
        // 地域性指示符号的 Unicode 标量可以组合成一个单一的 Character 值，
        // 例如 REGIONAL INDICATOR SYMBOL LETTER U(U+1F1FA)和 REGIONAL INDICATOR SYMBOL LETTER S(U+1F1F8)：
        let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
        // regionalIndicatorForUS 是 🇺🇸
        print("regionalIndicatorForUS: \(regionalIndicatorForUS)")
        
        
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
        
        
        // 标准相等（canonical equivalence）
        // 如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等，那就认为它们是相等的。
        // 只要可扩展的字形群集有同样的语言意义和外观则认为它们标准相等，即使它们是由不同的 unicode 标量构成。
        // 虽然这两种形式并不是等价的，因为包含不同的code point，却是标准相等的。
        // String：如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等，那就认为它们是相等的。
        //         == 和 compare 运算都是相等的。但是 isEqual 判断是不相等的，借助 decomposedStringWithCanonicalMapping 转换函数后再判断则相等
        // NSString：如果要做这种判断，需要借助 decomposedStringWithCanonicalMapping 转换函数后再判断
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


        // 兼容相等（compatibility equivalence）
        // 很多字符则在广义上是重复的，在Unicode标准中称为 compatibility equivalence ，兼容序列代表显示上不同但认为是等价字符
        // 例如： ligatures：字符ﬀ (LATIN SMALL LIGATURE FF, U+FB00) 与序列 ff (LATIN SMALL LETTER F + LATIN SMALL LETTER F, U+0066 U+0066)兼容，但不是标准相等，
        // 虽然它们可能渲染得完全一样，但取决于不同的上下文，typeface及文本渲染系统的能力。
        let strOne = "\u{FB00}"
        let strTwo = "\u{0066}\u{0066}"
        print("strOne.isEqual(strTwo): \(strOne.isEqual(strTwo))")
        print("strOne.decomposedStringWithCompatibilityMapping.isEqual(strTwo.decomposedStringWithCompatibilityMapping): \(strOne.decomposedStringWithCompatibilityMapping.isEqual(strTwo.decomposedStringWithCompatibilityMapping))")
        
        
        
        // 上述的两种等价方式带来四种 normalization form:
        
        //Canonical Equivalence
        //    Normalization Form D (NFD): 把单 code point 表示的字符拆开(Decompose)成多个 code point
        //        表示形式，并对一个字符的多个 code point //进行规范排序（比如一个字符上下各有一个点，
        //        那么总得有一个点对应的 code point 排在另一个点对应的 code //point 前面）；
        //    Normalization Form C(NFC)：把多个 code point 形式组合（compose）成单 code point 形式，
        //        如果没有单 code point 形式，则做一个正规排序
        //Compatibility Equivalence
        //    Normalization Form KD(NFKD): 这里的 K 指 Compatibility。意义与 NFD 类似。
        //    Normalization Form KC(NFKC): 意义与 NFC 类似。

        // 有个需要注意的点是，同一个 Unicode string，经过 NFD 再 NFC 后，其未必等于原始字符串，
        // 原因是有的同一个字符，在 Unicode 中有多个单 code point 表示，
        // 也许是规范制定过程中参与人员太多、字符太多、历时太长导致的失误或者兼容性考虑。



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
        //1.字符串长度不超过15位，内容直接放到变量内存中
        //  内存的后8个字节中最高位的1个字节（最高4位为E代表字符串类型，接着4位为字符串长度）
        //  内存的前8个字节中从低到高，后8个字节的前面7个字节从低到高存放字符串的值
        //2.长度超过15位，字符串内容存放在常量区
        //  内存中的后8个字节存放的是字符串内容真实存放的内存地址
        //  前8个字节存放的是字符串长度及标识符（标识符用来标记字符串存放到哪个区域）
        //3.追加导致长度变的超过15位拼接字符串，都会重新开辟堆空间存放字符串内容。
        
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
        //
        //
        // rax,eax,ax,ah,al 寄存器的关系
        // |63..32|31..16|15-8|7-0|
        //                |AH.|AL.|
        //                |AX.....|
        //        |EAX............|
        // |RAX...................|
        //
        //
        
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
        // 前面的e代表字符串标识（e代表字符串内存存储在变量里面的，0则代表字符串内存存储在堆里面，高8个字节如果存放指针的值，最高4位不会为e）。
        
        // 如果上面的 shortStr = "0123456789🐶"
        // 打印会是 0x3736353433323130 0xae00b6909ff03938
        // ⚠️：可以看到 emoji 按照 utf8 码元编码的四个码元值存放在内存中（b6 90 9f f0）

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
        
    
        // 字符串拼接操作引起的内存变化
        // 长度不超过15的字符串
        var strToAppend = "0123456789ABCD" // 最开始是14个字符
        print(Mems.memStr(ofVal: &strToAppend))
        strToAppend.append("E")
        print(Mems.memStr(ofVal: &strToAppend))
        strToAppend.append("F")
        print(Mems.memStr(ofVal: &strToAppend))
    }
}



