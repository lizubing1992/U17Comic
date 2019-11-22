//
//  Global.swift
//  U17Comic
//
//  Created by nongfadai on 2019/10/15.
//  Copyright © 2019 lizubing. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import MJRefresh

extension String{
    static let sexTypeKey = "sexTypeKey"
    static let searchHistoryKey = "searchHistory"
}

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//extension UIColor{
//    class var background: UIColor {
//        return UIColor(red: 242, green: 242, blue: 242)
//    }
//    class var theme: UIColor{
//        return UIColor(r:29, g:221, b:43)
//    }
//
//}
