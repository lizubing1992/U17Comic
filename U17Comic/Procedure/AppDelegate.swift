//
//  AppDelegate.swift
//  U17Comic
//
//  Created by nongfadai on 2019/10/12.
//  Copyright © 2019 lizubing. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //设置网络请求的host
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://app.u17.com")
    }()
    //设置屏幕方向
    var orientation:UIInterfaceOrientationMask = .portrait
    
    internal func application(_ application: UIApplication,didFinishLaunchWithOptions launchOPtions: [UIApplication.LaunchOptionsKey:Any]?) -> Bool{
        
        configBase()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UITabBarController()
        window?.makeKeyAndVisible()
        //MARK: 修正刘海屏
        return true
    }
    func configBase() {
        //MARK: 键盘处理
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        //MARK: 性别缓存
        let defaults = UserDefaults.standard
        if defaults.value(forKey: String.sexTypeKey) == nil{
            defaults.set(1, forKey: String.sexTypeKey)
            defaults.synchronize()
        }
        
        //MARK: 网络监控
        reachability?.listener = { status in
            switch status {
            case .reachable(.wwan):
//                展示网络情况
                break
            default:
                break
            }
        }
        //开始监听
        reachability?.startListening()
    }
 
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
   
}

//扩展函数
extension UIApplication{
       class func changeOrientationTo(landscapeRight:Bool){
        guard  let delegate = UIApplication.shared.delegate as? AppDelegate else{ return }
        if landscapeRight == true{
            delegate.orientation = .landscapeRight
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }else{
            delegate.orientation = .portrait
            UIApplication.shared.supportedInterfaceOrientations(for: delegate.window)
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
       }
   }





