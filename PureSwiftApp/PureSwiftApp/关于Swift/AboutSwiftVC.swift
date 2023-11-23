//
//  AboutSwiftVC.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/22.
//

import UIKit
import WebKit
import SnapKit

class AboutSwiftVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webVC = WKWebView()
        webVC.load(URLRequest.init(url: URL(string: "https://gitbook.swiftgg.team/swift/huan-ying-shi-yong-swift/01_about_swift")!))
        self.view.addSubview(webVC)
        webVC.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp_margins)
        }
        
//        let label = UILabel.init()
//        label.numberOfLines = 0;
//        label.text = """
//Swift 是一种非常好的编写软件的方式，无论是手机，台式机，服务器，还是其他运行代码的设备。它是一种安全，快速和互动的编程语言，将现代编程语言的精华和苹果工程师文化的智慧，以及来自开源社区的多样化贡献结合了起来。编译器对性能进行了优化，编程语言对开发进行了优化，两者互不干扰，鱼与熊掌兼得。
//
//Swift 对于初学者来说也很友好。它是一门满足工业标准的编程语言，但又有着脚本语言般的表达力和可玩性。它支持代码预览（playgrounds），这个革命性的特性可以允许程序员在不编译和运行应用程序的前提下运行 Swift 代码并实时查看结果。
//
//Swift 通过采用现代编程模式来避免大量常见编程错误：
//变量始终在使用前初始化。
//检查数组索引超出范围的错误。
//检查整数是否溢出。
//可选值确保明确处理 nil 值。
//内存被自动管理。
//错误处理允许从意外故障控制恢复。
//
//Swift 代码被编译和优化，以充分利用现代硬件。语法和标准库是基于指导原则设计的，编写代码的明显方式也应该是最好的。安全性和速度的结合使得 Swift 成为从 “Hello，world！” 到整个操作系统的绝佳选择。
//
//Swift 将强大的类型推理和模式匹配与现代轻巧的语法相结合，使复杂的想法能够以清晰简洁的方式表达。因此，代码不仅更容易编写，而且易于阅读和维护。
//
//Swift 已经进行了多年，并且随着新特性和功能的不断发展。我们对 Swift 的目标是雄心勃勃的。我们迫不及待想看到你用它创建出的东西。
//"""
//        
//        self.view.addSubview(label)
//        
//        label.snp.makeConstraints { make in
//            make.leadingMargin.equalToSuperview()
//            make.top.equalTo(self.view.snp_topMargin)
//            make.trailingMargin.equalToSuperview()
//        }
    }


}




