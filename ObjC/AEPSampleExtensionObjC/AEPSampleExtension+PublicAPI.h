/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
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
