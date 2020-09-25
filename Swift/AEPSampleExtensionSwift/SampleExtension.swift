/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

import Foundation
import AEPCore

@objc(AEPSampleExtension)
public class SampleExtension: NSObject, Extension {
    public var name: String = SampleExtensionConstants.EXTENSION_NAME
    public var friendlyName: String = SampleExtensionConstants.FRIENDLY_NAME
    public static let extensionVersion: String = SampleExtensionConstants.EXTENSION_VERSION
    public let runtime: ExtensionRuntime
    public var metadata: [String : String]?
    
    private var stateValue: String?

    public func onRegistered() {
        registerListener(type: EventType.custom, source: EventSource.requestContent, listener: requestContentListener)
    }
    
    public func onUnregistered() {}
    
    public required init?(runtime: ExtensionRuntime) {
        self.runtime = runtime
        super.init()
    }
    
    public func readyForEvent(_ event: Event) -> Bool {
        return getSharedState(extensionName: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: event)?.status == .set
    }
    
    // MARK: - Event Listeners
    private func requestContentListener(event: Event) {
        // First check if request is setter request or getter request
        if let data = event.data?[SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY] {
            self.stateValue = data as? String
            let extensionState: [String: Any] = [SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY: self.stateValue as Any]
            // Save new data to extension's shared state making it available for other extensions
            // and as a data element for rules processing
            createSharedState(data: extensionState, event: event)
        } else {
            let responseData: [String: Any] = [SampleExtensionConstants.EVENT_GETTER_RESPONSE_DATA_KEY: self.stateValue as Any]
            let responseEvent = event.createResponseEvent(name: "Get Data Example", type: EventType.custom, source: EventSource.responseContent, data: responseData)
            dispatch(event: responseEvent)
        }
    }
    
    
}
