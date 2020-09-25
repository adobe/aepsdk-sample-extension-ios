/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

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
        
        mockRuntime.simulateSharedState(for: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: getSampleDataEvent, data: ["testKey": "testValue"], status: .set)
        
        mockRuntime.simulateComingEvents([getSampleDataEvent])
        
        let responseEvent = mockRuntime.dispatchedEvents.first(where: { $0.responseID == getSampleDataEvent.id })
        XCTAssertNotNil(responseEvent)
        let data = responseEvent?.data?[SampleExtensionConstants.EVENT_GETTER_RESPONSE_DATA_KEY] as? String?
        XCTAssertTrue(data == nil)
    }
    
    func testSampleExtensionRequestContentWithDataSet() {
        let testDataValue = "testValue"
        let setDataEvent = Event(name: "Test Set Sample Data", type: EventType.custom, source: EventSource.requestContent, data: [SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY: testDataValue])
        
        mockRuntime.simulateSharedState(for: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: setDataEvent, data: ["testKey": "testValue"], status: .set)
        
        let getSampleDataEvent = Event(name: "Test Get Sample Data", type: EventType.custom, source: EventSource.requestContent, data: nil)

        mockRuntime.simulateSharedState(for: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: getSampleDataEvent, data: ["testKey": "testValue"], status: .set)
        
        mockRuntime.simulateComingEvents([setDataEvent, getSampleDataEvent])
        
        let responseEvent = mockRuntime.dispatchedEvents.first(where: { $0.responseID == getSampleDataEvent.id })
        XCTAssertNotNil(responseEvent)
        let data = responseEvent?.data?[SampleExtensionConstants.EVENT_GETTER_RESPONSE_DATA_KEY]
        XCTAssertEqual(data as? String, testDataValue)
    }
    
    func testSampleExtensionRequestContentSetSharedState() {
        
        let testDataValue = "testValue"
        let setDataEvent = Event(name: "Test Set Sample Data", type: EventType.custom, source: EventSource.requestContent, data: [SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY: testDataValue])
        
        mockRuntime.simulateSharedState(for: SampleExtensionConstants.SharedStateKeys.CONFIGURATION, event: setDataEvent, data: ["testKey": "testValue"], status: .set)
        
        mockRuntime.simulateComingEvents([setDataEvent])

        let sharedState = mockRuntime.createdSharedStates.last
        XCTAssertEqual(sharedState??[SampleExtensionConstants.EVENT_SETTER_REQUEST_DATA_KEY] as? String, testDataValue)
    }
}
