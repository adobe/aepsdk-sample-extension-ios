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
