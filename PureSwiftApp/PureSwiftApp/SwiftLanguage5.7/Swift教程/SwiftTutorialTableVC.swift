//
//  SwiftTutorialTableVC.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/25.
//

import UIKit

class SwiftTutorialTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let identifier = tableView.cellForRow(at: indexPath)?.textLabel?.text
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let destVC: SwiftChapterVC = storyboard.instantiateViewController(withIdentifier: "SwiftChapterVC") as! SwiftChapterVC
            destVC.title = identifier
            destVC.urlStr = urlStrForIdentifier(identifier!)
            destVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.navigationController?.pushViewController(destVC, animated: true)
        }
    }

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let identifier = segue.identifier
//        
//        if let dest = segue.destination as? SwiftChapterVC {
//            dest.urlStr = urlStrForIdentifier(identifier!)
//            dest.title = identifier
//        }
//    }
                
    func urlStrForIdentifier(_ identifier: String) -> String {
        let dict = [
            "基本运算符": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/02_basic_operators",
            "字符串和字符": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/03_strings_and_characters",
            "集合类型": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/04_collection_types",
            "控制流": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/05_control_flow",
            "函数": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/06_functions",
            "闭包": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/07_closures",
            "枚举": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/08_enumerations",
            "类和结构体": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/09_structures_and_classes",
            "属性": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/10_properties",
            "方法": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/11_methods",
            "下标": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/12_subscripts",
            "继承": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/13_inheritance",
            "构造过程": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/14_initialization",
            "析构过程": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/15_deinitialization",
            "可选链": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/16_optional_chaining",
            "错误处理": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/17_error_handling",
            "并发": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/28_concurrency",
            "类型转换": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/18_type_casting",
            "嵌套类型": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/19_nested_types",
            "扩展": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/20_extensions",
            "协议": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/21_protocols",
            "泛型": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/22_generics",
            "不透明类型": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/23_opaque_types",
            "自动引用计数": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/24_automatic_reference_counting",
            "内存安全": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/25_memory_safety",
            "访问控制": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/26_access_control",
            "高级运算符": "https://gitbook.swiftgg.team/swift/swift-jiao-cheng/27_advanced_operators",
        ]
        
        return dict[identifier]!
    }
}




