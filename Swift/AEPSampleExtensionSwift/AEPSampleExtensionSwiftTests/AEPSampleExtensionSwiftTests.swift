//
//  AEPSampleExtensionSwiftTests.swift
//  AEPSampleExtensionSwiftTests
//
//  Created by Christopher Hoffman on 8/13/20.
//  Copyright © 2020 Christopher Hoffman. All rights reserved.
//

import XCTest
import AEPCore
import AEPServices
@testable import AEPSampleExtensionSwift

class AEPSampleExtensionSwiftTests: XCTestCase {
    
    var sampleExt: SampleExtension!
    var mockRuntime: TestableExtensionRuntime!

    override func setUp() {
        mockRuntime = TestableExtensionRuntime()
        sampleExt = SampleExtension(runtime: mockRuntime)
        sampleExt.onRegistered()
    }

    func testSampleExtensionRequestContentNoDataSet() {
        let getSampleDataEvent = Event(name: "Test Get Sample Data", type: EventType.custom, source: EventSource.requestContent, data: nil)
        
        mockRuntime.simulateSharedState(for: (extensionName: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: getSampleDataEvent), data: (value: ["testKey": "testValue"], status: .set))
        
        mockRuntime.simulateComingEvents(getSampleDataEvent)
        
        let responseEvent = mockRuntime.dispatchedEvents.first(where: { $0.responseID == getSampleDataEvent.id })
        XCTAssertNotNil(responseEvent)
        let data = responseEvent?.data?[SampleExtensionConstants.EVENT_GETTER_RESPONSE_DATA_KEY]
        XCTAssertNil(data)
    }
    
    func testSampleExtensionRequestContentWithDataSet() {
        let testDataValue = "testValue"
        let setDataEvent = Event(name: "Test Set Sample Data", type: EventType.custom, source: EventSource.requestContent, data: [SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY: testDataValue])
        
        mockRuntime.simulateSharedState(for: (extensionName: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: setDataEvent), data: (value: ["testKey": "testValue"], status: .set))
        
        let getSampleDataEvent = Event(name: "Test Get Sample Data", type: EventType.custom, source: EventSource.requestContent, data: nil)

        mockRuntime.simulateSharedState(for: (extensionName: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: getSampleDataEvent), data: (value: ["testKey": "testValue"], status: .set))
        
        mockRuntime.simulateComingEvents(setDataEvent, getSampleDataEvent)
        
        let responseEvent = mockRuntime.dispatchedEvents.first(where: { $0.responseID == getSampleDataEvent.id })
        XCTAssertNotNil(responseEvent)
        let data = responseEvent?.data?[SampleExtensionConstants.EVENT_GETTER_RESPONSE_DATA_KEY]
        XCTAssertEqual(data as? String, testDataValue)
    }
    
    func testSampleExtensionRequestContentSetSharedState() {
        
        let testDataValue = "testValue"
        let setDataEvent = Event(name: "Test Set Sample Data", type: EventType.custom, source: EventSource.requestContent, data: [SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY: testDataValue])
        
        mockRuntime.simulateSharedState(for: (extensionName: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: setDataEvent), data: (value: ["testKey": "testValue"], status: .set))
        
        mockRuntime.simulateComingEvents(setDataEvent)

        let sharedState = mockRuntime.createdSharedStates.last
        XCTAssertEqual(sharedState??[SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY] as? String, testDataValue)
    }
}
