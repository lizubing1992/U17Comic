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
      
      lazy var reachability: NetworkReachabilityManager? = {
          return NetworkReachabilityManager(host: "http://app.u17.com")
      }()
      
      var orientation: UIInterfaceOrientationMask = .portrait
      


      internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
          
          configBase()
          
          window = UIWindow(frame: UIScreen.main.bounds)
          window?.backgroundColor = UIColor.white
          window?.rootViewController = UTabBarController()
          window?.makeKeyAndVisible()
          //MARK: 修正齐刘海
  //        UHairPowder.instance.spread()
          
          return true
      }
      
      func configBase() {
          //MARK: 键盘处理
          IQKeyboardManager.shared.enable = true
          IQKeyboardManager.shared.shouldResignOnTouchOutside = true
          
          //MARK: 性别缓存
          let defaults = UserDefaults.standard
          if defaults.value(forKey: String.sexTypeKey) == nil {
              defaults.set(1, forKey: String.sexTypeKey)
              defaults.synchronize()
          }

          //MARK: 网络监控
          reachability?.listener = { status in
              switch status {
              case .reachable(.wwan):
                  UNoticeBar(config: UNoticeBarConfig(title: "主人,检测到您正在使用移动数据")).show(duration: 2)
              default: break
              }
          }
          reachability?.startListening()
      }

      func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
          return orientation
      }

    // MARK: UISceneSession Lifecycle

   func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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





