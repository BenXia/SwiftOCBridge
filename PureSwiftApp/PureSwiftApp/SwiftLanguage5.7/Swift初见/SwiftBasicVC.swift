//
//  SwiftBasicVC.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/22.
//

import UIKit
import WebKit
import SnapKit

class SwiftBasicVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.testLetAndVar()
//        self.testOptionalUsage()
//        self.testGuard(person: ["name": "John", "location": "ShangHai"])
//        self.testAvailableCheck()
//        self.testTypeAlias()
        
        
//        self.testMultiLineString()
//        SwiftString.characterSetIntroduce()
//        SwiftString.memoryLayoutIntroduce()
//        SwiftStruct.memoryLayoutIntroduce()
//        SwiftArray.memoryLayoutIntroduce()


//        self.testArrayDict()
//        self.testForInLoop()
//        self.testSwitchUsage()


//        self.testFuncOverloading()  // 带默认参数的两个函数前缀重复竟然不报错
//        self.testDefaultArgFunc()
//        self.testFuncReturnTuple()
//        self.testFuncInFunc()
//        self.testReturnFunc()
//        self.testFuncArg()
//        self.testSuffixClosureArg()
//        self.testClosureCaptureVal()
//        self.testEscapingClosure()
//        self.testAutoClosure()
   
//        self.testEnum()
//        self.testStruct()
//        self.testObjectAndClass()
        
//        self.testOptionalChain()
//        self.testAsync()
//        self.testProtocolExtension()
//        self.testErrorHandle()
//        self.testDefer()
//        self.testGenerics()
        
        SwiftMethodDispatcher.testSwiftMethodDispatch()

        
        let webVC = WKWebView()
        webVC.load(URLRequest.init(url: URL(string: "https://gitbook.swiftgg.team/swift/huan-ying-shi-yong-swift/03_a_swift_tour")!))
        self.view.addSubview(webVC)
        webVC.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp_margins)
        }
    }
    
    func testLetAndVar() {
        // 总结:
        // let不管是值类型还是引用类型就相当于在最后加了个修饰符 const
        // let值类型相当于   int const
        // let引用类型相当于 NSString *const
        //
        // const NSString * 等价于 NSString const * 即指针指向不可改变的 NSString 对象（NSString本身即不可变，不需要）
        // NSString *const 指针是常量，不能修改指针指向
        //
        
        // let 常量如果是值类型的时候，则不能重新赋值值类型的变量，或者调用该值类型的属性修改方法
        // 即这个变量值类型不允许修改（注意：Int、String、Array、结构体、枚举 都是值类型）
//        let k = 1
//        k = 2
//        k += 1
//        
//        let str = "abc"
//        str += "def"
//        str = "xyz"
//
//        let array = [1, 2, 3]
//        array.append(4)
//        array += [4]
//
//        struct Animal {
//            var legs: Int = 0
//            
//            mutating setLegs(legs: Int) {
//                self.legs = legs
//            }
//        }
//        
//        let structVal = Animal()
//        structVal.legs = 4
//        structVal.setLegs(legs: 3)
        
        
        // let 常量如果是引用类型的时候，则不能重新赋值成其它对象
        // 但是该对象内部的属性修改方法都还是可以调用的
        // 即这个指针是个常量，不允许修改
        class Person {
            var name = ""
        }
        
        let obj = Person()
        obj.name = "hello"
        print("obj.name: \(obj.name)")
        
        let anotherObj = obj
        if obj === anotherObj {
            print("obj and anotherObj refer to the same Person instance.")
        }
        
        //obj = Person()
    }
    
    func testOptionalUsage() {
        // if let / guard let
        // 可选绑定
        let optionalString: String? = "Nick"
        print(optionalString == nil)
        
        if let name = optionalString {
            print("Hello, \(name)")
        }
        
        if let optionalString {
            print("Hello, \(optionalString)")
        }
        
        guard let name = optionalString else { return }
        
        print("Hello, \(name)")
        
        
        // 强制解析
        let url = URL(string: "https://www.baidu.com")
        
        if url != nil {
            let _ = URLRequest(url: url!)
        }
        
        
        // 隐式解析
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // 需要感叹号来获取值
        print("forcedString: \(forcedString)")

        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString  // 不需要感叹号
        print("implicitString: \(implicitString)")
        // optionString 的类型依然是 "String?"，assumedString 也没有被强制解析。
        let optionString = assumedString
        print("optionalString: \(optionString!)")
        
        
        // ?? 运算符
        let nickName: String? = nil
        let fullName: String = "XUJIE"
        print("Hi, \(nickName ?? fullName)")
    }
    
    func testGuard(person: [String: String]) {
        // 如果条件不被满足，在 else 分支上的代码就会被执行。
        // 这个分支必须转移控制以退出 guard 语句出现的代码段（否则编译器出报错）。
        // 它可以用控制转移语句如 return、break、continue 或者 throw 做这件事，
        // 或者调用一个不返回的方法或函数，例如 fatalError()。
        guard let name = person["name"] else {
            return
        }
        
        print("Hello \(name)!")
        
        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }
        
        print("I hope the weather is nice in \(location).")
    }
    
    func testAvailableCheck() {
        guard #available(iOS 10, macOS 10.12, *) else {
            return
        }
        
        if #available(iOS 10, macOS 10.12, *) {
            // 在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API
        } else {
            // 使用先前版本的 iOS 和 macOS 的 API
        }
        
        if #unavailable(iOS 10) {
            print("不支持的版本处理代码")
        }
    
        @available(iOS 10, *)
        @available(swift 5.0)
        struct ColorPreference {
            var bestColor = "blue"
        }
        
        if #available(iOS 10, *) {
            let colors = ColorPreference()
            print(colors.bestColor)
        }
    }
    
    func testTypeAlias() {
        typealias AudioSample = UInt16
        let maxAmplitudeFound = AudioSample.min
        
        print("typealias AudioSample value: \(maxAmplitudeFound)")
    }
    
    func testMultiLineString() {
        let apples = 3
        let oranges = 5
        let quotation = """

I said "I have \(apples) apples."\nAnd then I\
 said "I have \(apples + oranges) pieces of fruit."\"""

"""
        print(quotation)
        
        
        let quotation2 = #"""

I said "I have \(apples) apples."\#nAnd then I\#
 said "I have \(apples + oranges) pieces of fruit.""""

"""#
        print(quotation2)
        
        
        let quotation3 = #"""

I said "I have \#(apples) apples."\#nAnd then I\#
 said "I have \#(apples + oranges) pieces of fruit.""""

"""#
        print(quotation3)
        
        
        let quotation4 = """
   This line doesn't begin with whitespace.
       This line begins with four spaces.
   This line doesn't begin with whitespace.
   """
        print(quotation4)
    }
    
    func testArrayDict() {
        // 编译器类型推断
        var shoppingList = ["catfish", "water", "tulips", "blue paint"]
        shoppingList[1] = "bottle of water"
        shoppingList.append("blue paint")
        print(shoppingList)
        
        
        var occupations: Dictionary = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic"
        ]
        occupations["Jayne"] = "Public Relations"
        print(occupations)
        print("occupations[\"Hello\"]: \(occupations["Hello"] ?? "Optional.none")")
  
 
        var occupations2: Dictionary = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
            "Hello": nil
        ]

        occupations2["Jayne"] = "Public Relations"
        print(occupations2)
        print("occupations2[\"Hello\"]: \((occupations2["Hello"] ?? "Optional.none") ?? "Optional.Optional.none")")
        print("occupations2[\"world\"]: \((occupations2["world"] ?? "Optional.none") ?? "Optional.Optional.none")")
    }
    
    func testForInLoop() {
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largest = 0
        for (_, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
        }
        print("largest number is \(largest)")
        
        
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        
        
        print("\ni in 0..<4")
        for i in 0..<4 {
            print("i: \(i)")
        }
        
        print("\ni in 0...4")
        for i in 0...4 {
            print("i: \(i)")
        }
        
        print("\ni in 0...4 and terminator:\"\"")
        for i in 0...4 {
            print("\(i)", terminator: "")
        }
        
        
        // 开区间
        print("\n in stride(from:to:by:)")
        let hours = 12
        let hourInterval = 3
        for tickMark in stride(from: 3, to: hours, by: hourInterval) {
            print("stride(from:to:by:): \(tickMark)")
        }
        
        
        // 闭区间
        print("\n in stride(from:through:by:)")
        for tickMark in stride(from: 3, through: hours, by: hourInterval) {
            print("stride(from:through:by:): \(tickMark)")
        }
        
        
        // 带标签的循环语句（可以修饰 for/while）（方便里面的代码 break 标签/continue 标签 可以跨 switch/for/while 几层）
        let strToCheck = "xyz"
        forSteteMent: for ch in strToCheck {
            switch ch {
            case "y":
                break forSteteMent
            default:
                print("\(ch) is not y")
            }
        }
        
        var square = 0
        let finalSquare = 25
        var diceRoll = 0
        gameLoop: while square != finalSquare {
            diceRoll = Int(arc4random() % 6 + 1)
            
            switch square + diceRoll {
            case finalSquare:
                // 刚好到达最终方格位置，游戏结束
                print("+\(diceRoll)=\(finalSquare), Game over!")
                break gameLoop    // 此处不带标签，会知识结束 switch 语句，注意
            case let newSquare where newSquare > finalSquare:
                // 骰子数将会使玩家的移动超出最后的方格，
                // 那么这种移动是不合法的，玩家需要重新掷骰子
                continue gameLoop
            default:
                // 合法移动，做正常的处理
                square += diceRoll
                print("+\(diceRoll)", terminator: "")
            }
        }
    }
    
    func testSwitchUsage() {
        // 匹配 String 类型
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
        }
        
        // 匹配 Character 类型
        let someCharacter: Character = "z"
        switch someCharacter {
        case "a":
            print("The first letter of the alphabet")
        case "z":
            print("The last letter of the alphabet")
        default:
            print("Some other character")
        }
        
        
        // 匹配 enum 类型
        enum Fruit {
            case Apple
            case Orange
            case Banana
//            case Pear
        }
        
        var fruit = Fruit.Apple
        let value = arc4random() % 2
        if value == 0 {
            fruit = Fruit.Banana
        }
        // 通过 unknown default 提示编译器，只有未知的未来枚举类型才走 default 分支
        // 这样的话，如果有其它枚举 case 没写，编译器会给出警告
        switch(fruit) {
        case .Apple:
            print("Apple")
        case .Orange:
            print("Orange")
        case .Banana:
            fallthrough
//        default:
        @unknown default:
            print("Fruit neither apple or orange")
        }
        
        
        // Swift 中 switch case 中默认会 break，不需要写（如果某个 case 为空，编译器也会不通过，防止开发认为会贯穿）
        // 所以如果希望贯穿，需要自己写 fallthrough
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a": // 无效，这个分支下面没有语句
            fallthrough;  // 这种情况下必须手动根据情况手动写 break 或者 fallthrough（不能为空行）
        case "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        
        
        // 同时匹配多个值的复合匹配
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        
        
        // 整数类型支持区间匹配
        let approximateCount = arc4random()
        let countedThings = "moons orbiting Saturn"
        let naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("approximateCount: \(approximateCount)")
        print("There are \(naturalCount) \(countedThings).")
        
        
        // 匹配元组类型
        let somePoint = (Int(arc4random()%1 + 1), Int(arc4random()%1 + 1))
        switch somePoint {
        case (0, 0):
            print("\(somePoint) is at the origin")
        case (_, 0):
            print("\(somePoint) is on the x-axis")
        case (0, _):
            print("\(somePoint) is on the y-axis")
        case (-2...2, -2...2):
            print("\(somePoint) is inside the box")
        default:
            print("\(somePoint) is outside of the box")
        }
        
        
        // 匹配同时值绑定
        let anotherPoint = (Int(arc4random()%1 + 2), Int(arc4random()%1))
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        
        
        // 匹配同时配合 where 做额外条件判断
        let yetAnotherPoint = (Int(arc4random()%1 + 1), Int(arc4random()%1 - 1))
        switch yetAnotherPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        
        // 复合型 cases
        switch someCharacter {
        case "a", "e", "i", "o", "u":
            print("\(someCharacter) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacter) is a consonant")
        default:
            print("\(someCharacter) is not a vowel or a consonant")
        }
        
        
        // 复合型 + 值绑定
        let stillAnotherPoint = (Int(arc4random()%1 + 9), Int(arc4random()%1))
        switch stillAnotherPoint {
        case (let distance, 0), (0, let distance):
            print("On an axis, \(distance) from the origin")
        default:
            print("Not on an axis")
        }
        
        
        // switch 中的 break 语句（会结束 switch 判断语句）
        let strToCheck = "xyz"
        for ch in strToCheck {
            switch ch {
            case "y":
                break;
            default:
                print("\(ch) is not y")
            }
        }
        
        let numberSymbol: Character = "三"  // 简体中文里的数字 3
        var possibleIntegerValue: Int?
        switch numberSymbol {
        case "1", "١", "一", "๑":
            possibleIntegerValue = 1
        case "2", "٢", "二", "๒":
            possibleIntegerValue = 2
        case "3", "٣", "三", "๓":
            possibleIntegerValue = 3
        case "4", "٤", "四", "๔":
            possibleIntegerValue = 4
        default:
            break
        }
        if let integerValue = possibleIntegerValue {
            print("The integer value of \(numberSymbol) is \(integerValue).")
        } else {
            print("An integer value could not be found for \(numberSymbol).")
        }
        
        
        // 带标签的循环语句（可以修饰 for/while）（方便里面的代码 break 标签/continue 标签 可以跨 switch/for/while 几层）
        forSteteMent: for ch in strToCheck {
            switch ch {
            case "y":
                break forSteteMent
            default:
                print("\(ch) is not y")
            }
        }
        
        var square = 0
        let finalSquare = 25
        var diceRoll = 0
        gameLoop: while square != finalSquare {
            diceRoll = Int(arc4random() % 6 + 1)
            
            switch square + diceRoll {
            case finalSquare:
                // 刚好到达最终方格位置，游戏结束
                print("+\(diceRoll)=\(finalSquare), Game over!")
                break gameLoop    // 此处不带标签，会知识结束 switch 语句，注意
            case let newSquare where newSquare > finalSquare:
                // 骰子数将会使玩家的移动超出最后的方格，
                // 那么这种移动是不合法的，玩家需要重新掷骰子
                continue gameLoop
            default:
                // 合法移动，做正常的处理
                square += diceRoll
                print("+\(diceRoll)", terminator: "")
            }
        }
    }
    
    func testFuncOverloading() {
        // 只有2个参数时候，编译器会优先选择满足条件的最短参数列表的函数
        self.funcTest(a: 1, b: 1)
        self.funcTest(a: 2, b: 2, c:2)
        self.funcTest(a: 3, b: 3, c:3, d:3)
        
        print(greet("John", on: "Wednesday"))
        print(greet("Jack", "Tuesday"))
    }
    
    func funcTest(a: Int, b: Int) {
        print(self)
        print(#function)
        print("a=\(a), b=\(b)")
    }
    
    func funcTest(a: Int, b: Int, c:Int = 1) {
        print(self)
        print(#function)
        print("a=\(a), b=\(b), c=\(c)")
    }
    
    func funcTest(a: Int, b: Int, c:Int = 1, d:Int = 1) {
        print(self)
        print(#function)
        print("a=\(a), b=\(b), c=\(c), d=\(d)")
    }
    
    func greet(_ person: String, on day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    func greet(_ person: String, _ day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    func testDefaultArgFunc() {
        var result = testDefault(1, 2)
        print("result: \(result)")
        result = testDefault(1, 2, 3)
        print("result: \(result)")
        
        // 如果中间参数含有默认值，后面含有非默认值
        // 则函数调用时候必须至少带最后一个不含默认值之前的所有参数
        result = testDefault2(1, 3, 3)
        print("result: \(result)")
        result = testDefault2(1, 2, 3)
        print("result: \(result)")
    }
    
    func testDefault(_ a: Int, _ b: Int, _ c: Int = 3) -> Int {
        return c
    }
    
    func testDefault2(_ a: Int, _ b: Int = 2, _ c: Int, _ d: Int = 4) -> Int {
        return c
    }
    
    func testFuncReturnTuple() {
        let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
        print("min is \(bounds.min) and max is \(bounds.max)")
    }
    
    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    func testFuncInFunc() {
        print("func with inner func return \(self.returnFifteen())")
    }
    
    func returnFifteen() -> Int {
        var y = 10
        func add() {
            y += 5
        }
        add()
        return y
    }
    
    func testReturnFunc() {
        let increment = makeIncrement()
        print("increment(7) = \(increment(7))")
    }
    
    func makeIncrement() -> ((Int) -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        
        return addOne
    }
    
    func testFuncArg() {
        let numbers = [20, 19, 7, 12]
        let result = hasAnyMatches(list: numbers, condition: lessThanTen)
        print("\(result ? "has" : "not have") number less than ten")
    }
    
    func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
        for item in list {
            if condition(item) {
                return true
            }
        }
        
        return false
    }
    
    func lessThanTen(number: Int) -> Bool {
        return number < 10
    }
    
    func testSuffixClosureArg() {
        let numbers = [20, 19, 7, 12]
        
        // 尾随闭包精简写法（最后一个参数如果是闭包，直接跟在函数名后面即可）
        let mapNumbers1 = numbers.map { number in
            return number * 3
        }
        print("mapNumbers1 = \(mapNumbers1)")
        
        // 尾随闭包精简写法（参数用 $0、$1... 代替)
        let mapNumbers2 = numbers.map { $0 * 3 }
        print("mapNumbers2 = \(mapNumbers2)")
        
        let sortedNumbers = numbers.sorted { $0 < $1 }
        print("sortedNumbers = \(sortedNumbers)")
        
        let sortedNumbers2 = numbers.sorted(by: <)
        print("sortedNumbers2 = \(sortedNumbers2)")
        
        
        // 如果一个函数接受多个闭包，您需要省略第一个尾随闭包的参数标签，并为其余尾随闭包添加标签。
        loadPicture(from: "Main") { picture in
            print("got response: \(picture)")
        } onFailure: {
            print("load picture failed!")
        }
    }
    
    func loadPicture(from server: String, 
                     completion:(String) -> Void,
                     onFailure: () -> Void) {
        if let picture = download("photo.jpg", from: server) {
            completion(picture)
        } else {
            onFailure()
        }
    }
    
    func download(_ src: String, from server: String) -> String? {
        return "OK";
    }
    
    func testClosureCaptureVal() {
        // 函数和闭包本身都是引用类型
        
        // 如果捕获的是值类型，相当于函数或者闭包拷贝了一份值类型变量并持有
        let incrementByTen = makeIncrementer(forIncrement: 10)
        print(incrementByTen())
        print(incrementByTen())
        print(incrementByTen())
        
        let alsoIncrementByTen = incrementByTen
        print(alsoIncrementByTen())
        

        let incrementBySeven = makeIncrementer(forIncrement: 7)
        print(incrementBySeven())
        
        
        // 如果捕获的是引用类型，相当于函数或者闭包对其持有引用计数加一
        // 你将闭包赋值给一个类实例的属性，并且该闭包通过访问该实例或其成员而捕获了该实例，
        // 你将在闭包和该实例间创建一个循环强引用。
        // Swift 使用捕获列表来打破这种循环强引用。
    }
    
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    
    var x = 10
    func testEscapingClosure() {
        self.someFunctionWithEscapingClosure{
            self.x = 100
        }
        print("self.x: \(self.x)")
        
        self.someFunctionWithNonescapingClosure {
            x = 200
        }
        print("self.x: \(self.x)")
        
        self.completionHandlers.first?()
        print("self.x: \(self.x)")
    }
    
    var completionHandlers: [() -> Void] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }
    
    func testAutoClosure() {
        //
        // 自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。
        // 延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，
        // 因为它使得你能控制代码的执行时机。
        //
        // 过度使用 autoclosures 会让你的代码变得难以理解。
        // 上下文和函数名应该能够清晰地表明求值是被延迟执行的。
        //
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // 打印出“5”

        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        // 打印出“5”

        print("Now serving \(customerProvider())!")
        // 打印出“Now serving Chris!”
        print(customersInLine.count)
        // 打印出“4”
        
        serve(customer: customersInLine.remove(at: 0))
        
        
        // 如果你想让一个自动闭包可以“逃逸”
        // 则应该同时使用 @autoclosure 和 @escaping 属性。
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        print("Collected \(customerProviders.count) closures.")
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
    }
    
    func serve(customer customerProvider: @autoclosure () -> String) {
        if arc4random()%2 == 0 {
            print("Now serving \(customerProvider())!")
        } else {
            print("Busy now")
        }
    }
    
    var customerProviders: [() -> String] = []
    func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
        customerProviders.append(customerProvider)
    }
    
    enum Rank: Int {
        case ace = 1
        case two, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king
        
        func simpleDescription() -> String {
            switch self {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue)
            }
        }
    }
    
    enum Suit : CaseIterable {
        case spades, hearts, diamonds, clubs
        
        func simpleDescription() -> String {
            switch self {
            case .spades:
                return "spades"
            case .hearts:
                return "hearts"
            case .diamonds:
                return "diamonds"
            case .clubs:
                return "clubs"
            }
        }
    }
    
    enum CompassPoint: String {
        case north, south, east, west
    }
    
    func testEnum() {
        // 枚举成员可以被默认值（称为原始值）预填充
        // 这些原始值的类型必须相同。
        // 原始值可以是字符串、字符，或者任意整型值或浮点型值。
        // 每个原始值在枚举声明中必须是唯一的。
        
        // 在使用原始值为整数或者字符串类型的枚举时，
        // 不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值。
        // 当使用整数作为原始值时，隐式赋值的值依次递增 1。
        // 如果第一个枚举成员没有设置原始值，其原始值将为 0。
        let ace = Rank.ace
        let aceRawValue = ace.rawValue
        let aceTwo = Rank.ace
        
        print("ace: \(ace), aceRawValue: \(aceRawValue)")
        print("ace == aceTwo: \(ace == aceTwo)")
        
        // 当使用字符串作为枚举类型的原始值时，
        // 每个枚举成员的隐式原始值为该枚举成员的名称。
        let sunsetDirection = CompassPoint.west.rawValue
        let possibleCompassPoint = CompassPoint(rawValue: sunsetDirection)
        if let possibleCompassPoint {
            print("possibleCompassPoint: \(possibleCompassPoint)")
        }
        
        
        // 自带 init?(rawValue:) 的初始化构造器
        if let convertedRank = Rank(rawValue: 3) {
            // 枚举值是实际值，并不是原始值的另一种表达方法。
            // 实际上，如果没有比较有意义的原始值，你就不需要提供原始值。
            print("convertedRank: \(convertedRank)")
            print("convertedRank simpleDescription(): \(convertedRank.simpleDescription())")
            print("convertedRank rawValue: \(convertedRank.rawValue)")
        }
        
        

        
        let hearts = Suit.hearts
        let heartsDescription = hearts.simpleDescription()
        print("hearts: \(hearts)")
        print("hearts simpleDescription(): \(heartsDescription)")
        //没有 rawValue 打开下面这行会提示编译不通过
        //print("hearts rawValue: \(hearts.rawValue)")
        
        
        // 枚举成员的遍历
        // 只需要声明 Suit 遵循 CaseIterable 协议
        // 编译器会自动添加对 allCases 方法的实现
        let numberOfChoices = Suit.allCases.count
        print("\(numberOfChoices) suit available")
        for suitChoice in Suit.allCases {
            print(suitChoice)
        }
        
        
        // 当然我们也可以为枚举成员设定关联值，关联值是在创建实例时决定的。
        // 这意味着同一枚举成员不同实例的关联值可以不相同。
        // 你可以把关联值想象成枚举成员实例的存储属性。
        // 例如，考虑从服务器获取日出和日落的时间的情况。服务器会返回正常结果或者错误信息。
        enum ServerResponse {
            case result(String, String)
            case failure(String)
        }
        
        let success = ServerResponse.result("6:00 am", "8:09 pm")
        _ = ServerResponse.failure("Out of cheese.")
        
        switch success {
        case let .result(sunrise, sunset):
            print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
        case let .failure(message):
            print("Failure... \(message)")
        }
        
        
        
        // 递归枚举
        enum ArithmeticExpression {
            case number(Int)
            indirect case addition(ArithmeticExpression, ArithmeticExpression)
            indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
        }
        
        func evaluate(_ expression: ArithmeticExpression) -> Int {
            switch expression {
            case let .number(value):
                return value
            case let .addition(left, right):
                return evaluate(left) + evaluate(right)
            case let .multiplication(left, right):
                return evaluate(left) * evaluate(right)
            }
        }
        
        let five = ArithmeticExpression.number(5)
        let four = ArithmeticExpression.number(4)
        let sum = ArithmeticExpression.addition(five, four)
        let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
        
        print("product calc result: \(evaluate(product))")
    }
    
    func testStruct() {
        // 结构体和类有很多相同的地方，包括方法和构造器。
        // 它们之间最大的一个区别就是结构体是传值，类是传引用。
        struct Card {
            var rank: Rank
            var suit: Suit
            func simpleDescription() -> String {
                return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
            }
        }
        
        // 默认逐一构造器
        let threeOfSpades = Card(rank: Rank.three, suit: Suit.spades)
        let threeOfSpadesDescription = threeOfSpades.simpleDescription()
        print("threeOfSpades: \(threeOfSpades)")
        print("threeOfSpades simpleDescription(): \(threeOfSpadesDescription)")
        
        
        // 结构体中函数修改成员变量时，需要 mutating 修饰 func
        struct Resolution {
            var width = 0
            var height = 0
            
            mutating func set(width: Int) {
                self.width = width
            }
        }
        
        var someResolution = Resolution()
        someResolution.set(width: 10)
        print("someResolution.width: \(someResolution.width)")
    }
    
    // Swift 中结构体和类有很多共同点。两者都可以：
    //  定义属性用于存储值
    //  定义方法用于提供功能
    //  定义下标操作用于通过下标语法访问它们的值
    //  定义构造器用于设置初始值
    //  通过扩展以增加默认实现之外的功能
    //  遵循协议以提供某种标准功能
    
    // 结构体特殊的地方
    //   结构体是值类型
    //   函数修改成员变量时，需要 mutating 修饰 func
    
    // 与结构体相比，类还有如下的附加功能：
    //   继承允许一个类继承另一个类的特征
    //   类型转换允许在运行时检查和解释一个类实例的类型
    //   析构器允许一个类实例释放任何其所被分配的资源
    //   引用计数允许对一个类的多次引用
    
    func testObjectAndClass() {
        let shape = Shape()
        shape.numberOfSides = 7
        print(shape.simpleDescription())
        
        
        let square = Square(sideLength: 5.2, name: "my test square")
        print("square.area() = \(square.area())\n\(square.simpleDescription())")
        let parentRef: NamedShape = square as NamedShape
        print("parentRef.simpleDescription(): \(parentRef.simpleDescription())")
        
        
        let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print("triangle.perimeter = \(triangle.perimeter)");
        triangle.perimeter = 9.9
        print("triangle.sideLength = \(triangle.sideLength)");
        
        
        let triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print(triangleAndSquare.square.sideLength)
        print(triangleAndSquare.triangle.sideLength)
        triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
        print(triangleAndSquare.triangle.sideLength)
        
        
        // 注意引用类型的区别
        let shapeObj = Shape()
        shapeObj.numberOfSides = 7
        let anotherShapeObj = shapeObj
        anotherShapeObj.numberOfSides = 8
        print("shapeObj: \(shapeObj.simpleDescription())")
        print("anotherShapeObj: \(anotherShapeObj.simpleDescription())")
        
        if shapeObj === anotherShapeObj {
            print("shapeObj and anotherShapeObj refer to the same Shape instance.")
        }
    }
    
    func testOptionalChain() {
        let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
        let sideLength = optionalSquare?.sideLength
        
        print("sideLength: \(sideLength ?? 0)")
    }
    
    func testAsync() {
        // 使用 Task 从同步代码中调用异步函数且不等待它们返回结果
        
        Task {
            await connectUser(to: "primary")
            print("此处依然是在主线程执行")
        }
        
        print("不阻塞当前的函数继续执行，返回结果")
        
        // 更多 async/await 替代传统的 Result 闭包回调的兼容性方案
        // 参考：https://zhuanlan.zhihu.com/p/620981473
    }

    func connectUser(to server: String) async {
        // 使用 async let 来调用异步函数，并让其与其它异步函数并行运行。
        // 使用 await 以使用该异步函数返回的值。
        async let userID = fetchUserID(from: server)
        async let username = fetchUsername(from: server)
        let greeting = await "Hello \(username), user ID \(userID)"
        print(greeting)
    }
    
    // 使用 async 标记异步运行的函数
    func fetchUserID(from server: String) async -> Int {
        if server == "primary" {
            return 97
        }
        return 501
    }
    
    // 通过在函数名前添加 await 来标记对异步函数的调用
    func fetchUsername(from server: String) async -> String {
        let userID = await fetchUserID(from: server)
        if userID == 501 {
            return "John Appleseed"
        }
        return "Guest"
    }
    
    func testProtocolExtension() {
        // 类、枚举和结构体都可以遵循协议
        let a = SimpleClass()
        a.adjust()
        let aDescription = a.simpleDescription
        print("aDescription: \(aDescription)")
        
        
        // 注意声明 SimpleStructure 时候 mutating 关键字用来标记一个会修改结构体的方法。
        // SimpleClass 的声明不需要标记任何方法，因为类中的方法通常可以修改类属性（类的性质）。
        var b = SimpleStructure()
        b.adjust()
        let bDescription = b.simpleDescription
        print("bDescription: \(bDescription)")
        
        
        
        // 使用 extension 来为现有的类型添加功能，比如新的方法和计算属性。
        // 你可以使用扩展让某个在别处声明的类型来遵守某个协议，这同样适用于从外部库或者框架引入的类型。
        var c = 7
        c.adjust()
        let cDescription = c.simpleDescription
        print("cDescription: \(cDescription)")
        
        

        // 你可以像使用其他命名类型一样使用协议名
        // 例如，创建一个有不同类型但是都实现一个协议的对象集合。
        // 当你处理类型是协议的值时，协议外定义的方法不可用。
        let protocolValue: ExampleProtocol = a
        print(protocolValue.simpleDescription)
        
        //即使 protocolValue 变量运行时的类型是 simpleClass ，
        //编译器还是会把它的类型当做 ExampleProtocol。
        //这表示你不能调用在协议之外的方法或者属性。
        //print(protocolValue.anotherProperty) // 去掉注释可以看到错误
        
        //可以在代码中添加类型可选转换
        if let d = protocolValue as? SimpleClass {
            print(d.anotherProperty)
        }
    }
    
    func testErrorHandle() {
        // 有多种方式可以用来进行错误处理。
        
        // 一种方式是使用 do-catch 。
        // 在 do 代码块中，使用 try 来标记可以抛出错误的代码。
        // 在 catch 代码块中，除非你另外命名，否则错误会自动命名为 error 。
        do {
            //let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
            let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
            print("response: \(printerResponse)")
        } catch {
            print("error: \(error)")
        }
        
        // 可以使用多个 catch 块来处理特定的错误。
        // 参照 switch 中的 case 风格来写 catch。
        do {
            let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
            print(printerResponse)
        } catch PrinterError.onFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch let printError as PrinterError {
            print("Printer error: \(printError).")
        } catch {
            print(error)
        }
        
        
        
        // 另一种处理错误的方式使用 try? 将结果转换为可选的。
        // 如果函数抛出错误，该错误会被抛弃并且结果为 nil。
        // 否则，结果会是一个包含函数返回值的可选值。
        let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
        _ = try? send(job: 1885, toPrinter: "Never Has Toner")
        
        if let result = printerSuccess {
            print("Printer result: \(result)")
        }
    }
    
    // 使用 defer 代码块来表示在函数返回前，函数中最后执行的代码。
    // 无论函数是否会抛出错误，这段代码都将执行。
    // 使用 defer，可以把函数调用之初就要执行的代码和函数调用结束时的
    // 扫尾代码写在一起，虽然这两者的执行时机截然不同。
    //
    // 常见：
    // 1.加锁后解锁
    // 2.打开文件后关闭文件
    // 3.添加观察后去除观察
    func testDefer() {
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]
        
        func fridgeContains(_ food: String) -> Bool {
            fridgeIsOpen = true
            defer {
                fridgeIsOpen = false
            }
            
            let result = fridgeContent.contains(food)
            return result
        }
        
        print("fridgeContains(\"banana\") = \(fridgeContains("banana"))")
        print(fridgeIsOpen)
    }
    
    func testGenerics() {
        // 在尖括号里写一个名字来创建一个泛型函数或者类型。
        let array = makeArray(repeating: "knock", numberOfTimes: 4)
        print("array: \(array)")
        
        
        // 也可以创建泛型函数、方法、类、枚举和结构体。
        // 重新实现 Swift 标准库中的可选类型
        var possibleInteger: OptionalValue<Int> = .none
        possibleInteger = .some(100)
        print("possibleInteger: \(possibleInteger)")
        
        
        // 在类型名后面使用 where 来指定对类型的一系列需求，
        // 比如，限定类型实现某一个协议，限定两个类型是相同的，
        //      或者限定某个类必须有一个特定的父类。
        print("[1, 2, 3] and [3] have any common elements? : \(anyCommonElements([1, 2, 3], [3]) ? "yes" : "no")")
        
        let commonItems = commonElements([1, 2, 3], [3])
        print("[1, 2, 3] and [3] have common elements: \(commonItems)")
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    // 计算属性 set 和 get
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}

class TriangleAndSquare {
    // 存储属性 willSet 和 didSet
    var triangle: EquilateralTriangle = EquilateralTriangle(sideLength: 3, name: "default") {
        willSet {
            square.sideLength = newValue.sideLength
        }
        didSet {
            print("triangle sideLength newValue: \(triangle.sideLength)")
        }
    }
    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
        didSet {
            print("square sideLenghth newValue: \(square.sideLength)")
        }
    }
    // 初始化方法init内对存储属性 self.xxx 或者 xxx 设置值都不会触发 willSet 与 didSet
    // 在初始化器中设置属性值不会触发 willSet 和 didSet
    // 在属性定义时设置初始值也不会触发 willSet 和 didSet
    init(size: Double, name: String) {
        self.square = Square(sideLength: size, name: name)
        self.triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}





protocol ExampleProtocol {
    // 既可以是存储属性，也可以是计算属性
    var simpleDescription: String { get }
    mutating func adjust()
}

// 类、枚举和结构体都可以遵循协议
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += " Now 100% adjusted."
    }
}

// 注意声明 SimpleStructure 时候 mutating 关键字用来标记一个会修改结构体的方法。
// SimpleClass 的声明不需要标记任何方法，因为类中的方法通常可以修改类属性（类的性质）。
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += "(adjusted"
    }
}


// 使用 extension 来为现有的类型添加功能，比如新的方法和计算属性。
// 你可以使用扩展让某个在别处声明的类型来遵守某个协议，这同样适用于从外部库或者框架引入的类型。
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}




// 采用 Error 协议的类型来表示错误。
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

// 在尖括号里写一个名字来创建一个泛型函数或者类型。
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result: [Item] = []
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

// 也可以创建泛型函数、方法、类、枚举和结构体
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}

// 在类型名后面使用 where 来指定对类型的一系列需求，
// 比如，限定类型实现某一个协议，限定两个类型是相同的，
//      或者限定某个类必须有一个特定的父类。
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
where T.Element: Equatable, T.Element == U.Element {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    
    return false
}

func commonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> [T.Element]
where T.Element: Equatable, T.Element == U.Element {
    var result: [T.Element] = []
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                result.append(lhsItem)
            }
        }
    }
    return result
}





