//
//  AEPSampleExtension+PublicAPI.m
//  AEPSampleExtensionObjC
//
//  Created by Christopher Hoffman on 8/25/20.
//  Copyright © 2020 Christopher Hoffman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEPSampleExtension+PublicAPI.h"
#import "AEPSampleExtensionConstants.h"

@implementation AEPSampleExtension (PublicAPI)

+(void)getSampleDataListenerExample:(void (^)(NSString * _Nullable))completion {
    AEPEvent * event = [[AEPEvent alloc] initWithName:@"Get Sample Data" type:EVENT_TYPE_CUSTOM source:EVENT_SOURCE_RESPONSE_CONTENT data:nil];
    
    [AEPCore dispatch:event responseCallback:^(AEPEvent * _Nullable responseEvent) {
        if (!responseEvent) {
            completion(nil);
            return;
        }
        
        if (responseEvent.data[EVENT_GETTER_RESPONSE_KEY]) {
            NSString * sampleData = (NSString *)responseEvent.data[EVENT_GETTER_RESPONSE_KEY];
            if (!sampleData) {
                completion(nil);
                return;
            }
            completion(sampleData);
        }
    }];
}

+(void)setterDataExample:(NSString *)data {
    NSDictionary * requestData = @{EVENT_SETTER_REQUEST_KEY: data};
    AEPEvent * requestEvent = [[AEPEvent alloc] initWithName:@"Set Data Example" type:EVENT_TYPE_CUSTOM source:EVENT_SOURCE_REQUEST_CONTENT data:requestData];
    [AEPCore dispatch:requestEvent];
}

@end
