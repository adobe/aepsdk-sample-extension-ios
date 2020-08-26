/*
Copyright 2020 Adobe. All rights reserved.
This file is licensed to you under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License. You may obtain a copy
of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under
the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
OF ANY KIND, either express or implied. See the License for the specific language
governing permissions and limitations under the License.
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
