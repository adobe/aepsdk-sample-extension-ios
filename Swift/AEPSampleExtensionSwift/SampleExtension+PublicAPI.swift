/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

import Foundation
import AEPCore

/// Defines the public interface for the Sample Extension
@objc public extension SampleExtension {
    
    @objc(getSampleDataListenerExample:)
    static func getSampleDataListenerExample(completion: @escaping (String?, AEPError) -> Void) {
        let event = Event(name: "Get Sample Data", type: EventType.custom, source: EventSource.responseContent, data: nil)
        
        MobileCore.dispatch(event: event, responseCallback: { responseEvent in
            guard let responseEvent = responseEvent else {
                completion(nil, .callbackTimeout)
                return
            }
            
            guard let sampleData = responseEvent.data?[SampleExtensionConstants.EVENT_GETTER_RESPONSE_DATA_KEY] as? String else {
                completion(nil, .unexpected)
                return
            }
            
            completion(sampleData, .none)
        })
    }
    
    @objc(setterDataExample:)
    static func setterDataExample(data: String) {
        let requestData = [SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY: data]
        let requestEvent = Event(name: "Set Data Example", type: EventType.custom, source: EventSource.requestContent, data: requestData)
        MobileCore.dispatch(event: requestEvent)
    }
    
}
