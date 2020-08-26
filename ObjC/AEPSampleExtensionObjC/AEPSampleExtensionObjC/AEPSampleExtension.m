//
//  AEPSampleExtension.m
//  AEPSampleExtensionObjC
//
//  Created by Christopher Hoffman on 8/24/20.
//  Copyright © 2020 Christopher Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEPSampleExtension.h"
#import "AEPSampleExtensionConstants.h"


@implementation AEPSampleExtension {
    id<AEPExtensionRuntime> runtime_;
    NSString * stateValue;
}

- (NSString *)friendlyName {
    return FRIENDLY_NAME;
}

- (NSString *)name {
    return EXTENSION_NAME;
}

- (NSDictionary<NSString *,NSString *> *)metadata {
    return nil;
}

- (id<AEPExtensionRuntime>)runtime {
    return runtime_;
}

+ (NSString * _Nonnull)extensionVersion {
    return EXTENSION_VERSION;
}

- (nullable instancetype)initWithRuntime:(id<AEPExtensionRuntime> _Nonnull)runtime {
    self = [super init];
    runtime_ = runtime;
    return self;
}

- (void)onRegistered {
    [runtime_ registerListenerWithType:EVENT_TYPE_CUSTOM source:EVENT_SOURCE_REQUEST_CONTENT listener:^(AEPEvent * _Nonnull event) {
        [self requestContentListener:event];
    }];
}

- (void)onUnregistered {}

- (BOOL)readyForEvent:(AEPEvent * _Nonnull)event {
    AEPSharedStateResult *result = [runtime_ getSharedStateWithExtensionName:SHARED_STATE_CONFIGURATION_KEY event:event];
    if (!result) {
        return false;
    }
    
    return result.status == AEPSharedStateStatusSet;
}

- (void) requestContentListener:(AEPEvent * _Nonnull)event {
    // First check if request is setter request or getter request
    if (!event.data[EVENT_SETTER_REQUEST_KEY]) {
        NSDictionary *responseData = stateValue ? @{EVENT_GETTER_RESPONSE_KEY: stateValue} : nil;
        AEPEvent *responseEvent = [event responseEventWithName:@"Get Data Example" type:AEPEventType.custom source:AEPEventSource.responseContent data:responseData];
        [runtime_ dispatchWithEvent:responseEvent];
    } else {
        stateValue = (NSString *)event.data[EVENT_SETTER_REQUEST_KEY];
        NSDictionary *extensionState = @{EVENT_SETTER_REQUEST_KEY: stateValue};
        // Save new data to extension's shared state making it available for other extensions
        // and as a data element for rules processing
        [runtime_ createSharedStateWithData:extensionState event:event];
    }
}

@end

