//
//  InterfaceController.swift
//  WatchVolume Extension
//
//  Created by Thomas Kluge on 08.01.17.
//  Copyright © 2017 kSquare.de. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController , WCSessionDelegate {
  
  @IBOutlet var volumePicker: WKInterfacePicker!
  @IBOutlet var pickerGroup: WKInterfaceGroup!
  
  var session: WCSession!
  var prgSet:Bool = false
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    let pickerItems: [WKPickerItem] = (0...10).map {
      let item =  WKPickerItem()
      if ($0 == 0) {
        item.title = "Mute"
      } else {
        let v = $0*10
        item.title = "\(v) %"
      }
      return item;
    }
    volumePicker.setItems(pickerItems)
    
    let images : [UIImage] = (0...10).map {
      let v = $0*10
      return  UIImage(named: "volume_\(v)")!
    }
    
    let progressImages = UIImage.animatedImage(with: images, duration: 0.0)
    pickerGroup.setBackgroundImage(progressImages)
    
    volumePicker.setCoordinatedAnimations([pickerGroup])
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  override func didAppear() {
    super.didAppear()
    if WCSession.isSupported() {
      session = WCSession.default()
      session.delegate = self
      session.activate()
    }
  }
  
  
  @IBAction func volumePickerDidChange(_ value: Int) {
    
    if (prgSet==false) {
      
      let newVolume = NSNumber(value: Float(value)/10)
      session.sendMessage(["newVolume": newVolume], replyHandler: { (response) -> Void in
      }, errorHandler: { (error) -> Void in
        
        print(error)
      })
    }
    
    self.prgSet = false
  }
  
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?)
  {
    session.sendMessage(["getVolume":""], replyHandler: { (response) -> Void in
      
      if let volume = response["currentVolume"] as? NSNumber {
        DispatchQueue.main.async {
          self.prgSet = true
          self.volumePicker.setSelectedItemIndex(Int(volume.floatValue * 10))
          
        }
      }
      
      
    }, errorHandler: { (error) -> Void in
      
      print(error)
    })
  }
  
  
}


