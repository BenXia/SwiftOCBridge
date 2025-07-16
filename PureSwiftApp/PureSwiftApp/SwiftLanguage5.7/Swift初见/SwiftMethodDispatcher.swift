//
//  SwiftMethodDispatcher.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/12/4.
//

import Foundation

class SwiftMethodDispatcher {
    static func testSwiftMethodDispatch() {
        // 详见文章：https://segmentfault.com/a/1190000008063625
        // 见图：SwiftMethodDispatch.png
        // 1.直接派发（Direct Dispatch）（静态调用）
        // 2.函数表派发（Table Dispatch）（见图：TableDispatch.png）
        // 编译型语言有三种基础的函数派发方式: 直接派发(Direct Dispatch), 函数表派发(Table Dispatch) 和 消息机制派发(Message Dispatch), 下面我会仔细讲解这几种方式. 大多数语言都会支持一到两种, Java 默认使用函数表派发, 但你可以通过 final 修饰符修改成直接派发. C++ 默认使用直接派发, 但可以通过加上 virtual 修饰符来改成函数表派发. 而 Objective-C 则总是使用消息机制派发, 但允许开发者使用 C 直接派发来获取性能的提高.
//        class ParentClass {
//            func method1() {
//                print("ParentClass::method1")
//            }
//            func method2() {
//                print("ParentClass::method2")
//            }
//        }
//        class ChildClass: ParentClass {
//            override func method2() { 
//                print("ChildClass::method2")
//            }
//            func method3() {}
//        }
//        let obj = ChildClass()
//        obj.method2()


        // 3.消息机制派发（Message Dispatch）（见图：MessageDispatch.png）
//        class ParentClass {
//            dynamic func method1() {
//                print("ParentClass::method1")
//            }
//            dynamic func method2() {
//                print("ParentClass::method2")
//            }
//        }
//        class ChildClass: ParentClass {
//            override func method2() {
//                print("ChildClass::method2")
//            }
//            dynamic func method3() {
//                print("ChildClass::method3")
//            }
//        }
//        let obj = ChildClass()
//        obj.method2()


        // 4. 四个影响派发方式的因素存在
        // 4-1.声明的位置（见图：LocationMatters.png）
        // 4-2.引用类型
        // 4-3.特定的行为（指定派发方式）（见图：ModifierOverview.png）
        // 4-4.显式地优化


        // 4-1.声明的位置 & 4-2.引用类型
//        let myStruct = MyStruct()
//        let proto: MyProtocol = myStruct
//        // 如果把函数的定义放到 protocol 中会走函数表转发，否则下面两个都是直接派发
//        // LocationMatters 中主要是指函数的定义（声明）放的位置
//        myStruct.extensionMethod()
//        proto.extensionMethod()


        // 如果把函数的定义放到 protocol 中会走函数表转发，否则下面两个都是直接派发
        // LocationMatters 中主要是指函数的定义（声明）放的位置
        // 结合5-2的代码，发现函数表派发如果用协议引用类型调用需要实现协议的基类中必须有方法的实现，否则还是会调用协议扩展中的实现（见5-2.test1）
        // 如果使用类引用，则该类及其父类没有方法的实现，则还是会调用协议扩展中的实现，否则会函数派发实现多态（见5-2.test1）
//        let myClass = MyClass()
//        let proto2: MyProtocol = myClass
//        myClass.extensionMethod()
//        proto2.extensionMethod()


        // 5.有趣 errors and bugs 源码
        // 5-1.code（最新的 swift 版本编译不过）
        // 编译器已经不允许子类的 extension 中重写父类的方法
//        greetings(person: Person())
//        greetings(person: MisunderstoodPerson())


        // 5-2.code
        // 发现函数表派发如果用协议引用类型调用需要实现协议的基类中必须有方法的实现，否则还是会调用协议扩展中的实现（见test1）
        // 如果使用类引用，则该类及其父类没有方法的实现，则还是会调用协议扩展中的实现，(跟协议的基类中有没有声名没关系)，否则会函数派发实现多态（见test1）
        greetings(greeter: People())
        greetings(greeter: LoudPeople())
        greetings(greeter: LoudLoudPeople())
        let loudloudPeople = LoudLoudPeople()
        let loudPeople: LoudPeople = loudloudPeople
        let people: People = loudloudPeople
        people.sayHi()
        loudPeople.sayHi()
        loudloudPeople.sayHi()
    }
}

// 4-2.引用类型 code
protocol MyProtocol {
    // ⚠️：放开下面这行注释，则会使用函数表派发
    //func extensionMethod()
}
struct MyStruct: MyProtocol {
}
extension MyProtocol {
    func extensionMethod() {
        print("协议")
    }
}
extension MyStruct {
    func extensionMethod() {
        print("结构体")
    }
}
class MyClass: MyProtocol {
    func extensionMethod() {
        print("类")
    }
}

// 5-1.code（最新的 swift 版本编译不过）
// 编译器已经不允许子类的 extension 中重写父类的方法
//class Person: NSObject {
//    @objc dynamic func sayHi() {
//        print("Hello")
//    }
//}
//func greetings(person: Person) {
//    person.sayHi()
//}
//class MisunderstoodPerson: Person {
//}
//extension MisunderstoodPerson {
//    @objc override func sayHi() {
//        print("No one gets me.")
//    }
//}

// 5-2.code
protocol Greetable {
    func sayHi()
}
extension Greetable {
    func sayHi() {
        print("Hello")
    }
}
func greetings(greeter: Greetable) {
    greeter.sayHi()
}
class People: Greetable {
    // 1.test

    // 2.test
//    func sayHi() {
//        print("People HELLO")
//    }
}

//extension People {
//    // 3.test
//    @objc func sayHi() {
//        print("People HELLO from extension")
//    }
//}

class LoudPeople: People {
    // 1.test
    func sayHi() {
        print("LoudPeople HELLO")
    }
    
    // 2.test
}

class LoudLoudPeople: LoudPeople {
    override func sayHi() {
        print("LoudLoudPeople HELLO")
    }
}

// 5-3.code（最新的 swift 版本编译不过）
// 编译器已经不允许子类重写父类的 extension 中的方法
//class MyClassName {
//}
//extension MyClassName {
//    func extensionMethod() {
//    }
//}
//class SubClass: MyClassName {
//    override func extensionMethod() {
//    }
//}




