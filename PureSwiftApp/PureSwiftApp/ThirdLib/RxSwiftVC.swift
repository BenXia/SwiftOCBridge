//
//  SwiftBasicVC.swift
//  PureSwiftApp
//
//  Created by Ben on 2023/11/22.
//

import UIKit
import WebKit
import SnapKit
import Collections
import RxSwift

class RxSwiftVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testSubject()
    }
    
    func testSubject() {
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
         
        subject.onNext("Hello, RxSwift!")
         
        let subscriptionOne: Disposable = subject
            .subscribe(onNext: { string in
                print(string)
            })
        subscriptionOne.disposed(by: disposeBag)
         
        subject.onNext("Hello again, RxSwift!")
         
        subscriptionOne.dispose()
         
        let subscriptionTwo: Disposable = subject
            .subscribe(onNext: { string in
                print(string)
            })
        subscriptionTwo.disposed(by: disposeBag)
         
        subject.onNext("Hello again and again, RxSwift!")
    }
}





