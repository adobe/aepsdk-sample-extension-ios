/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

#import <XCTest/XCTest.h>
#import "AEPSampleExtension.h"
#import "AEPSampleExtensionObjCTests-Swift.h"
#import "AEPSampleExtensionConstants.h"
@import AEPSampleExtensionObjC;
@import AEPCore;

@interface AEPSampleExtensionObjCTests : XCTestCase
    
@end

@implementation AEPSampleExtensionObjCTests {
    AEPSampleExtension * sampleExt;
    AEPTestableExtensionRuntime * mockRuntime;
}

- (void)setUp {
    mockRuntime = [[AEPTestableExtensionRuntime alloc] init];
    sampleExt = [[AEPSampleExtension alloc] initWithRuntime:mockRuntime];
    [sampleExt onRegistered];
}

-(void) testSampleExtensionRequestContentNoDataSet {
    AEPEvent * getSampleDataEvent = [[AEPEvent alloc] initWithName:@"Test Get Sample Data" type:AEPEventType.custom source:AEPEventSource.requestContent data:nil];
    
    [mockRuntime simulateSharedStateFor:SHARED_STATE_CONFIGURATION_KEY event:getSampleDataEvent data:@{@"testKey": @"testValue"} status:AEPSharedStateStatusSet];
    
    [mockRuntime simulateComingEvents:@[getSampleDataEvent]];
    
    AEPEvent * responseEvent;
    
    for (AEPEvent *event in [mockRuntime dispatchedEvents]) {
        if ([event.responseID isEqual:getSampleDataEvent.id]) {
            responseEvent = event;
        }
    }
    
    XCTAssertNotNil(responseEvent);
    if (responseEvent) {
        NSString * data = (NSString *)responseEvent.data[EVENT_GETTER_RESPONSE_KEY];
        XCTAssertNil(data);
    }
}

-(void) testSampleExtensionRequestContentSetSharedState {
    NSString * testDataValue = @"testValue";
    AEPEvent * setDataEvent = [[AEPEvent alloc] initWithName:@"Test Set Sample Data" type:EVENT_TYPE_CUSTOM source:EVENT_SOURCE_REQUEST_CONTENT data:@{EVENT_SETTER_REQUEST_KEY: testDataValue}];
    
    [mockRuntime simulateSharedStateFor:SHARED_STATE_CONFIGURATION_KEY event:setDataEvent data:@{@"testKey": @"testValue"} status:AEPSharedStateStatusSet];
    
    AEPEvent * getSampleDataEvent = [[AEPEvent alloc] initWithName:@"Test Get Sample Data" type:EVENT_TYPE_CUSTOM source:EVENT_SOURCE_REQUEST_CONTENT data:nil];
    
    [mockRuntime simulateSharedStateFor:SHARED_STATE_CONFIGURATION_KEY event:getSampleDataEvent data:@{@"testKey": @"testValue"} status:AEPSharedStateStatusSet];
    
    [mockRuntime simulateComingEvents:@[setDataEvent, getSampleDataEvent]];
    
    AEPEvent * responseEvent;
    
    for (AEPEvent *event in [mockRuntime dispatchedEvents]) {
        if ([event.responseID isEqual:getSampleDataEvent.id]) {
            responseEvent = event;
        }
    }
    
    XCTAssertNotNil(responseEvent);
    NSString * data = (NSString*)responseEvent.data[EVENT_GETTER_RESPONSE_KEY];
    XCTAssertEqual(data, testDataValue);

}



@end
