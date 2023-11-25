//
//  SwiftChapterVC.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/22.
//

import UIKit
import WebKit
import SnapKit

class SwiftChapterVC: UIViewController {
    var urlStr: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        let webVC = WKWebView()
        webVC.load(URLRequest.init(url: URL(string: self.urlStr!)!))
        self.view.addSubview(webVC)
        webVC.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp_margins)
        }
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




