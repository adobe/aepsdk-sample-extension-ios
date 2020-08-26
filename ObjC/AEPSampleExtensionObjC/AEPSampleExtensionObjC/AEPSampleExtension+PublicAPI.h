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

#ifndef AEPSampleExtension_PublicAPI_h
#define AEPSampleExtension_PublicAPI_h
#import "AEPSampleExtension.h"
@import AEPCore;

NS_ASSUME_NONNULL_BEGIN

@interface AEPSampleExtension (PublicAPI)

+(void)getSampleDataListenerExample:(void (^) (NSString * __nullable data))completion;
+(void)setterDataExample:(NSString  *)data;

@end

NS_ASSUME_NONNULL_END

#endif /* AEPSampleExtension_PublicAPI_h */
