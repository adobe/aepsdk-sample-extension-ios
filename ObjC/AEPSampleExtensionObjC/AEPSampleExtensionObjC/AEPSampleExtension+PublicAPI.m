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
