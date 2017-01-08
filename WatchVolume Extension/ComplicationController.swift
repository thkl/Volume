//
//  ComplicationController.swift
//  WatchVolume Extension
//
//  Created by Thomas Kluge on 08.01.17.
//  Copyright © 2017 kSquare.de. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
  
  
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(NSDate(timeIntervalSinceNow: (60 * 60 * 24)) as Date)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population

  
  public func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {

    var template : CLKComplicationTemplate?
    
    // TODO: fetch Current Volume
    
    let volumeText = CLKSimpleTextProvider.localizableTextProvider(withStringsFileTextKey: "Volume", shortTextKey: "Vol")
    
    switch (complication.family) {
      
    case .modularSmall:
      let modularSmall = CLKComplicationTemplateModularSmallRingImage()
      modularSmall.imageProvider = CLKImageProvider(onePieceImage: UIImage(named:"Complication/Modular")!)
      template = modularSmall
      
    case .extraLarge:
      let extraLarge = CLKComplicationTemplateExtraLargeStackText()
      extraLarge.line1TextProvider = volumeText
      template = extraLarge
      
    case .circularSmall:
      let csmall = CLKComplicationTemplateCircularSmallRingImage()
      csmall.imageProvider = CLKImageProvider(onePieceImage: UIImage(named:"Complication/Circular")!)
      template = csmall
      
      
    case .utilitarianSmall:
      let usmall = CLKComplicationTemplateUtilitarianSmallRingImage()
      usmall.imageProvider = CLKImageProvider(onePieceImage: UIImage(named:"Complication/Circular")!)
      template = usmall
      
      
    default:
      break;
    }
    
    if (template != nil) {
      let entry = CLKComplicationTimelineEntry(date: Date() , complicationTemplate: template!)
      handler(entry)
    } else {
      handler(nil)
    }
    
  }

  
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
  
  func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    
    let template: CLKComplicationTemplate?
    
    let volumeText = CLKSimpleTextProvider.localizableTextProvider(withStringsFileTextKey: "Volume", shortTextKey: "Vol")
    
    switch complication.family {
    case .modularSmall:
      let modularSmall = CLKComplicationTemplateModularSmallRingImage()
      modularSmall.imageProvider = CLKImageProvider(onePieceImage: UIImage(named:"Complication/Modular")!)
      template = modularSmall

    case .extraLarge:
      let extraLarge = CLKComplicationTemplateExtraLargeStackText()
      extraLarge.line1TextProvider = volumeText
      template = extraLarge
    
    case .circularSmall:
      let csmall = CLKComplicationTemplateCircularSmallRingImage()
      csmall.imageProvider = CLKImageProvider(onePieceImage: UIImage(named:"Complication/Circular")!)
      template = csmall
      
      
    case .utilitarianSmall:
      let usmall = CLKComplicationTemplateUtilitarianSmallRingImage()
      usmall.imageProvider = CLKImageProvider(onePieceImage: UIImage(named:"Complication/Circular")!)
      template = usmall
      
      
    default:
      template = nil
    }
    
    handler(template)
  }
}
