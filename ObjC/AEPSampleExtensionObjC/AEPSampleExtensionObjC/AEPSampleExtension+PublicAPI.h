//
//  AEPSampleExtension+PublicAPI.h
//  AEPSampleExtensionObjC
//
//  Created by Christopher Hoffman on 8/25/20.
//  Copyright © 2020 Christopher Hoffman. All rights reserved.
//

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
