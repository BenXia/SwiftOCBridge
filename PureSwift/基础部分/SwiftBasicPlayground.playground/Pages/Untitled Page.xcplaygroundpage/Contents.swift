//: Playground - noun: a place where people can play

import UIKit

/*******************/
/*     基础部分     */
/*******************/

// 这是一个注释

/* 这是一个,
 多行注释 */

/* 这是第一个多行注释的开头
 /* 这是第二个被嵌套的多行注释 */
 这是第一个多行注释的结尾 */

let kInt : Int = 2

let kDouble : Double = 2.0

let kFloat : Float = 2.0

let kBool : Bool = true

let kString : String = "Hello, Swift"

let kMaximumNumberOfLoginAttempts = 10

var currentLoginAttempt = 0

var x = 0.0, y=0, z = 0.0

var welcomeMessage : String = "Welcome to swift language"

var red, green, blue : Double

let π = 3.14159

let 你好 = "你好世界"

let 🐶🐮 = "dogcow"º

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"

//let languageName = "Swift"
//languageName = "Swift++"

print(friendlyWelcome, separator:"-", terminator:"\n")
print("The current value of friendlyWelcome is \(friendlyWelcome)")

let cat = "🐱"; print(cat)

var vInt8 : Int8 = 127
var vInt64 : Int64 = 1000
var vUInt8 : UInt8 = 127
var vUInt64 : UInt64 = 1000
var vIntDefault : Int = 1000

let minValue = UInt8.min
let maxValue = UInt8.max
let minInt64Value = Int64.min
let maxInt64Value = Int64.max
let minIntValue = Int.min
let maxIntValue = Int.max

// 在32位平台上，Int 和 Int32 长度相同。
// 在64位平台上，Int 和 Int64 长度相同。

//注意：
//尽量不要使用UInt，除非你真的需要存储一个和当前平台原生字长相同的无符号整数。除了这种情况，最好使用Int，即使你要存储的值已知是非负的。统一使用Int可以提高代码的可复用性，避免不同类型数字之间的转换，并且匹配数字的类型推断，请参考类型安全和类型推断。
// 通常来讲，即使代码中的整数常量和变量已知非负，也请使用Int类型。总是使用默认的整数类型可以保证你的整数常量和变量可以直接被复用并且可以匹配整数类字面量的类型推断。
// 只有在必要的时候才使用其他整数类型，比如要处理外部的长度明确的数据或者为了优化性能、内存占用等等。使用显式指定长度的类型可以及时发现值溢出并且可以暗示正在处理特殊数据。

let kPI = 3.1415926
let kPI_Double : Double = 3.1415926
let kPI_Float : Float = 3.1415926
print("kPI=\(kPI) kPI_Double=\(kPI_Double) kPI_Float=\(kPI_Float)")

let meaningOfLife = 42
// meaningOfLife 会被推测为 Int 类型

let kpiValue = 3.14159
// pi 会被推测为 Double 类型

let anotherPi = 3 + 0.14159
// anotherPi 会被推测为 Double 类型

let decimalInteger = 17
let binaryInteger = 0b10001       // 二进制的17
let octalInteger = 0o21           // 八进制的17
let hexadecimalInteger = 0x11     // 十六进制的17

// 1.25e2 表示 1.25 × 10^2，等于 125.0。
// 1.25e-2 表示 1.25 × 10^-2，等于 0.0125。
// 0xFp2 表示 15 × 2^2，等于 60.0。
// 0xFp-2 表示 15 × 2^-2，等于 3.75。

let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

//let cannotBeNegative: UInt8 = -1
//// UInt8 类型不能存储负数，所以会报错
//let tooBig: Int8 = Int8.max + 1
//// Int8 类型不能存储超过最大值的数，所以会报错

//======整数转换
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

//======整数和浮点数转换
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi 等于 3.14159，所以被推测为 Double 类型

let integerPi = Int(pi)
// integerPi 等于 3，所以被推测为 Int 类型


//======类型别名
typealias AudioSample = UInt16

var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound 现在是 0

//=======布尔值
let orangesAreOrange = true
let turnipsAreDelicious = false
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

//=======if后面不是Bool
let i = 1
//if i {
//    // 编译会报错
//}

if i == 1 {
    print("This is ok");
}

//=======元组
let http404Error = (404, "Not Found")
// http404Error 的类型是 (Int, String)，值是 (404, "Not Found")

// 将一个元组的内容分解（decompose）成单独的常量和变量
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")

// 如果你只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

// 还可以通过下标来访问元组中的单个元素，下标从零开始
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")

// 可以在定义元组的时候给单个元素命名,给元组中的元素命名后，你可以通过名字来获取这些元素的值
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
// 输出 "The status code is 200"
print("The status message is \(http200Status.description)")
// 输出 "The status message is OK"

//=======可选类型
// 1.有值，等于 x   
// 2.没有值
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 被推测为类型 "Int?"， 或者类型 "optional Int"

var serverResponseCode: Int? = 404
// serverResponseCode 包含一个可选的 Int 值 404
serverResponseCode = nil
// serverResponseCode 现在不包含值

//注意：
//nil不能用于非可选的常量和变量。如果你的代码中有常量或者变量需要处理值缺失的情况，请把它们声明成对应的可选类型。

var surveyAnswer: String?
// surveyAnswer 被自动设置为 nil
//注意：
//Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。


//=======可选类型的四种解析方式
//=======1.if 语句以及强制解析
//当你确定可选类型确实包含值之后，你可以在可选的名字后面加一个感叹号（!）来获取值。这个惊叹号表示“我知道这个可选有值，请使用它。
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

//=======2.可选绑定
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}
// 输出 "'123' has an integer value of 123"

if let firstNumber = Int("abc"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
} else {
    print("Not satisfy")
}

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

//=======3.隐式解析可选类型
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值

// 有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型_总会_有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。这种类型的可选状态被定义为隐式解析可选类型（implicitly unwrapped optionals）。把想要用作可选的类型的后面的问号（String?）改成感叹号（String!）来声明一个隐式解析可选类型。
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号




//=======错误处理
//func makeASandwich() throws {
//    // ...
//}
//
//func eatASandwich() {
//    
//}
//
//func washDishes() {
//    
//}
//
//func buyGroceries(a:Int) {
//    
//}
//
//do {
//    try makeASandwich()
//    eatASandwich()
//} catch SandwichError.outOfCleanDishes {
//    washDishes()
//} catch SandwichError.missingIngredients(let ingredients) {
//    buyGroceries(ingredients)
//}


//=======断言
//let age = -3
//assert(age >= 0, "A person's age cannot be less than zero")
//// 因为 age < 0，所以断言会触发


//: [Previous](@previous)


