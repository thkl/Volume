//
//  AppDelegate.swift
//  Volume
//
//  Created by Thomas Kluge on 08.01.17.
//  Copyright © 2017 kSquare.de. All rights reserved.
//

import UIKit
import WatchConnectivity
import MediaPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , WCSessionDelegate{

  var window: UIWindow?

  var session: WCSession? {
    didSet {
      if let session = session {
        session.delegate = self
        session.activate()
      }
    }
  }


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    if WCSession.isSupported() {
      session = WCSession.default()
    }
    return true
  }

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

  func changeVolume(newLevel : Float) {
    (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(newLevel, animated: false)
  }


  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
    
    if let newVolume = message["newVolume"] as? NSNumber {
      let volume = newVolume.floatValue
      self.changeVolume(newLevel: volume);
      replyHandler(["volumeChanged": NSNumber(value: volume)])
    }
    
    if (message["getVolume"] as? String) != nil {
      let volume = AVAudioSession.sharedInstance().outputVolume
      replyHandler(["currentVolume": NSNumber(value: volume)])
    }
  }

  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
  {
    
  }
  
  func sessionDidBecomeInactive(_ session: WCSession) {
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
  }

  
}

