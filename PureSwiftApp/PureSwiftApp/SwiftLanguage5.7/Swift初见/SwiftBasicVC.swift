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
        
//        self.testMultiLineString()
//        self.testSameFunc()
//        SwiftString.characterSetIntroduce()
        SwiftString.memoryLayoutIntroduce()
//        self.testArrayDict()
//        SwiftStruct.memoryLayoutIntroduce()
//        SwiftArray.memoryLayoutIntroduce()
//        self.testTypeAlias()
//        self.testOptionalUsage()
//        self.testSwitchUsage()
//        self.testForInLoop()
//        self.testFuncAndClosure()
//        self.testObjectAndClass()
//        self.testOptionalChain()
//        self.testEnumAndStruct()
//        self.testAsync()
//        self.testProtocolExtension()
//        self.testErrorHandle()
//        self.testDefer()
//        self.testGenerics()

        let webVC = WKWebView()
        webVC.load(URLRequest.init(url: URL(string: "https://gitbook.swiftgg.team/swift/huan-ying-shi-yong-swift/03_a_swift_tour")!))
        self.view.addSubview(webVC)
        webVC.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp_margins)
        }
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
    }
    
    func testSameFunc() {
        self.funcTest(a: 1, b: 2)
        self.funcTest(a: 2, b: 3, c:3)
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
    
    func testArrayDict() {
        // 编译器类型推断
        var shoppingList = ["catfish", "water", "tulips", "blue paint"]
        shoppingList[1] = "bottle of water"
        shoppingList.append("blue paint")
        print(shoppingList)
  
 
        var occupations = [
            "Malcolm": "Captain",
            "Kaylee": "Mechanic",
        ]
        occupations["Jayne"] = "Public Relations"
        print(occupations)
    }
    
    func testTypeAlias() {
        typealias AudioSample = UInt16
        let maxAmplitudeFound = AudioSample.min
        
        print("typealias AudioSample value: \(maxAmplitudeFound)")
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
    
    func testSwitchUsage() {
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
        switch(fruit) {
        case .Apple:
            print("Apple")
        case .Orange:
            print("Orange")
        case .Banana:
            fallthrough
        @unknown default:
            print("Fruit neither apple or orange")
        }
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
        
        
        print("\ni in 0..<4")
        for i in 0..<4 {
            print("i: \(i)")
        }
        
        print("\ni in 0...4")
        for i in 0...4 {
            print("i: \(i)")
        }
    }
    
    func testFuncAndClosure() {
        print(greet("John", on: "Wednesday"))
        print(greet("Jack", "Tuesday"))
        
        
        let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
        print(statistics.sum)
        print(statistics.2)
        
        
        print("func with inner func return \(self.returnFifteen())")
        
        
        let increment = makeIncrement()
        print("increment(7) = \(increment(7))")
        
        
        let numbers = [20, 19, 7, 12]
        let result = hasAnyMatches(list: numbers, condition: lessThanTen)
        print("\(result ? "has" : "not have") number less than ten")
        
        
        
        let mapNumbers1 = numbers.map { number in
            return number * 3
        }
        print("mapNumbers1 = \(mapNumbers1)")
        
        let mapNumbers2 = numbers.map { $0 * 3 }
        print("mapNumbers2 = \(mapNumbers2)")
        
        let sortedNumbers = numbers.sorted { $0 < $1 }
        print("sortedNumbers = \(sortedNumbers)")
    }
    
    func greet(_ person: String, on day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    func greet(_ person: String, _ day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min {
                min = score
            }
            
            sum += score
        }
        
        return (min, max, sum)
    }
    
    func returnFifteen() -> Int {
        var y = 10
        func add() {
            y += 5
        }
        add()
        return y
    }
    
    func makeIncrement() -> ((Int) -> Int) {
        func addOne(number: Int) -> Int {
            return 1 + number
        }
        
        return addOne
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
    
    func testObjectAndClass() {
        let shape = Shape()
        shape.numberOfSides = 7
        print(shape.simpleDescription())
        
        
        let square = Square(sideLength: 5.2, name: "my test square")
        print("square.area() = \(square.area())\n\(square.simpleDescription())")
        
        
        let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print("triangle.perimeter = \(triangle.perimeter)");
        triangle.perimeter = 9.9
        print("triangle.sideLength = \(triangle.sideLength)");
        
        
        let triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print(triangleAndSquare.square.sideLength)
        print(triangleAndSquare.triangle.sideLength)
        triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
        print(triangleAndSquare.triangle.sideLength)
    }
    
    func testOptionalChain() {
        let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
        let sideLength = optionalSquare?.sideLength
        
        print("sideLength: \(sideLength ?? 0)")
    }
    
    func testEnumAndStruct() {
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
        
        let ace = Rank.ace
        let aceRawValue = ace.rawValue
        let aceTwo = Rank.ace
        
        print("ace: \(ace), aceRawValue: \(aceRawValue)")
        print("ace == aceTwo: \(ace == aceTwo)")
        
        
        // 自带 init?(rawValue:) 的初始化构造器
        if let convertedRank = Rank(rawValue: 3) {
            // 枚举值是实际值，并不是原始值的另一种表达方法。
            // 实际上，如果没有比较有意义的原始值，你就不需要提供原始值。
            print("convertedRank: \(convertedRank)")
            print("convertedRank simpleDescription(): \(convertedRank.simpleDescription())")
            print("convertedRank rawValue: \(convertedRank.rawValue)")
        }
        
        
        enum Suit {
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
        
        let hearts = Suit.hearts
        let heartsDescription = hearts.simpleDescription()
        print("hearts: \(hearts)")
        print("hearts simpleDescription(): \(heartsDescription)")
        //没有 rawValue 打开下面这行会提示编译不通过
        //print("hearts rawValue: \(hearts.rawValue)")
        
        
        
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





