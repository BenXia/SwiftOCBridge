//
//  SwiftVersionVC.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/22.
//

import UIKit
import WebKit
import SnapKit

class SwiftVersionVC: UIViewController {
    private weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = WKWebView()
        webView = view
        webView.load(URLRequest.init(url: URL(string: "https://gitbook.swiftgg.team/swift/huan-ying-shi-yong-swift/02_version_compatibility")!))
        self.view.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp_margins).inset(UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
        }
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("点击查看更多历史版本变更信息", for: UIControl.State.normal)
        button.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        if #available(iOS 14.0, *) {
            button.addAction(UIAction.init(handler: { _ in
                self.webView.load(URLRequest.init(url: URL(string: "https://gitbook.swiftgg.team/swift/huan-ying-shi-yong-swift/04_revision_history")!))
            }), for: UIControl.Event.touchUpInside)
        } else {
            button.addTarget(self, action: #selector(loadMoreInfo), for: UIControl.Event.touchUpInside)
        }
        self.view.addSubview(button)

        button.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
        
    @objc func loadMoreInfo() {
        webView.load(URLRequest.init(url: URL(string: "https://gitbook.swiftgg.team/swift/huan-ying-shi-yong-swift/04_revision_history")!))
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




