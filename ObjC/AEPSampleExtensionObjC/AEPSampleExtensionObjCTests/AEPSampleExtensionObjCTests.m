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
