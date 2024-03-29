/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

@testable import AEPCore
import Foundation

/// Testable implementation for `ExtensionRuntime`
///
/// Enable easy setup for the input and verification of the output of an extension
@objc(AEPTestableExtensionRuntime)
public class TestableExtensionRuntime: NSObject, ExtensionRuntime {

    
        
    public var listeners: [String: EventListener] = [:]
    @objc public var dispatchedEvents: [Event] = []
    public var createdSharedStates: [[String: Any]?] = []
    @objc public var mockedSharedStates: [String: SharedStateResult] = [:]

    override public init() {
        super.init()
    }

    // MARK: - ExtensionRuntime methods implementation

    public func registerListener(type: String, source: String, listener: @escaping EventListener) {
        listeners["\(type)-\(source)"] = listener
    }

    public func dispatch(event: Event) {
        dispatchedEvents += [event]
    }

    public func createSharedState(data: [String: Any], event _: Event?) {
        createdSharedStates += [data]
    }

    public func createPendingSharedState(event _: Event?) -> SharedStateResolver {
        return { data in
            self.createdSharedStates += [data]
        }
    }

    public func getSharedState(extensionName: String, event: Event?, barrier: Bool) -> SharedStateResult? {
        // if there is an shared state setup for the specific (extension, event id) pair, return it. Otherwise, return the shared state that is setup for the extension.
        if let id = event?.id {
            return mockedSharedStates["\(extensionName)-\(id)"] ?? mockedSharedStates["\(extensionName)"]
        }
        return mockedSharedStates["\(extensionName)"]
    }
    
    public func createXDMSharedState(data: [String : Any], event: Event?) {
        
    }
    
    public func createPendingXDMSharedState(event: Event?) -> SharedStateResolver {
        return { data in
            self.createdSharedStates += [data]
        }
    }
    
    public func getXDMSharedState(extensionName: String, event: Event?) -> SharedStateResult? {
        return nil
    }

    public func unregisterExtension() {}
    
    public func startEvents() {}

    public func stopEvents() {}

    // MARK: - Helper methods

    /// Simulate the events that are being sent to event hub, if there is a listener registered for that type of event, that listener will receive the event
    /// - Parameters:
    ///   - events: the sequence of the events
    @objc public func simulateComingEvents(_ events: [Event]) {
        for event in events {
            listeners["\(event.type)-\(event.source)"]?(event)
            listeners["\(EventType.wildcard)-\(EventSource.wildcard)"]?(event)
        }
    }

    /// Get the listener that is registered for the specific event source and type
    /// - Parameters:
    ///   - type: event type
    ///   - source: event source
    @objc public func getListener(type: String, source: String) -> EventListener? {
        return listeners["\(type)-\(source)"]
    }

    /// Simulate the shared state of an extension for a matching event
    /// - Parameters:
    ///   - pair: the (extension, event) pair
    ///   - data: the shared state tuple (value, status)
    @objc public func simulateSharedState(for extensionName: String, event: Event, data: [String: Any]?, status: SharedStateStatus) {
        mockedSharedStates["\(extensionName)-\(event.id)"] = SharedStateResult(status: status, value: data)
    }

    /// Simulate the shared state of an certain extension ignoring the event id
    /// - Parameters:
    ///   - extensionName: extension name
    ///   - data: the shared state tuple (value, status)
    @objc public func simulateSharedState(for extensionName: String, data: [String: Any]?, status: SharedStateStatus) {
        mockedSharedStates["\(extensionName)"] = SharedStateResult(status: status, value: data)
    }

    /// clear the events and shared states that have been created by the current extension
    @objc public func resetDispatchedEventAndCreatedSharedStates() {
        dispatchedEvents = []
        createdSharedStates = []
    }
}

extension TestableExtensionRuntime {
    public var firstEvent: Event? {
        dispatchedEvents[0]
    }

    public var secondEvent: Event? {
        dispatchedEvents[1]
    }

    public var thirdEvent: Event? {
        dispatchedEvents[2]
    }

    public var firstSharedState: [String: Any]? {
        createdSharedStates[0]
    }

    public var secondSharedState: [String: Any]? {
        createdSharedStates[1]
    }

    public var thirdSharedState: [String: Any]? {
        createdSharedStates[2]
    }
}
