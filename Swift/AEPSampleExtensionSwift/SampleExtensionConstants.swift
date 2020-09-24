/*
 Copyright 2020 Adobe
 All Rights Reserved.
 
 NOTICE: Adobe permits you to use, modify, and distribute this file in
 accordance with the terms of the Adobe license agreement accompanying
 it.
 */

import Foundation

enum SampleExtensionConstants {
    static let EXTENSION_NAME = "com.sampleCompany.module.sample"
    static let FRIENDLY_NAME = "Sample"
    static let EXTENSION_VERSION = "1.0.0"
    static let EVENT_GETTER_RESPONSE_DATA_KEY = "getterdata"
    static let EVENT_SETTER_REQUEST_DATA_KEY = "setterdata"
    
    enum SharedStateKeys {
        static let CONFIGURATION = "com.adobe.module.configuration"
    }
}
