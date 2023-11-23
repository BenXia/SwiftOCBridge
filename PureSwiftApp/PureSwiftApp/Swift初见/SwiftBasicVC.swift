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
        
        self.testMultiLineString()
        self.testSameFunc()
        self.testArrayDict()
        self.testOptionalUsage()
        self.testSwitchUsage()
        self.testForInLoop()
        self.testFuncAndClosure()
        self.testObjectAndClass()

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
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""
        print(quotation)
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
    
    func testOptionalUsage() {
        // if let / guard let
        // 可选绑定
        var optionalString: String? = "Nick"
        print(optionalString == nil)
        
        if let name = optionalString {
            print("Hello, \(name)")
        }
        
        if let optionalString {
            print("Hello, \(optionalString)")
        }
        
        guard let name = optionalString else { return }
        
        print("Hello, \(name)")
        
        
        
        // !
        // 强制解析，或者隐式解析可选类型
        let url = URL(string: "https://www.baidu.com")
        
        if url != nil {
            let request = URLRequest(url: url!)
        }
        
        let url2: URL? = URL(string: "https://www.baidu.com")
        let reqeust2 = URLRequest(url: url2!)
        
        let url3: URL! = URL(string: "https://www.baidu.com")
        let reqeust3 = URLRequest(url: url3)
        
        
        
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
        var value = arc4random() % 2
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
        
        
        var increment = makeIncrement()
        print("increment(7) = \(increment(7))")
        
        
        var numbers = [20, 19, 7, 12]
        var result = hasAnyMatches(list: numbers, condition: lessThanTen)
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
        var shape = Shape()
        shape.numberOfSides = 7
        print(shape.simpleDescription())
        
        
        let square = Square(sideLength: 5.2, name: "my test square")
        print("square.area() = \(square.area())\n\(square.simpleDescription())")
        
        
        let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
        print("triangle.perimeter = \(triangle.perimeter)");
        triangle.perimeter = 9.9
        print("triangle.sideLength = \(triangle.sideLength)");
        
        
        var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
        print(triangleAndSquare.square.sideLength)
        print(triangleAndSquare.triangle.sideLength)
        triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
        print(triangleAndSquare.triangle.sideLength)
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








