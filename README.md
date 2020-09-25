# AEP SDK Sample Extension for iOS

## BETA ACKNOWLEDGEMENT

AEP SDK Sample Extension for iOS is currently in Beta. Use of this code is by invitation only and not otherwise supported by Adobe. Please contact your Adobe Customer Success Manager to learn more.

By using the Beta, you hereby acknowledge that the Beta is provided "as is" without warranty of any kind. Adobe shall have no obligation to maintain, correct, update, change, modify or otherwise support the Beta. You are advised to use caution and not to rely in any way on the correct functioning or performance of such Beta and/or accompanying materials.

## About this Project

This repository contains a sample implementation of an iOS extension for the AEP SDK. Example implementations are provided for both Objective-c and Swift.

## Requirements

- Xcode 11.0 or newer
- Swift 5.1 or newer (Swift project only)
- Cocoapods 1.6 or newer

## Installation

#### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
# Podfile
use_frameworks!

# for app development, include all the following pods
target 'YOUR_TARGET_NAME' do
    # install the Swift extension
    pod 'AEPSampleExtensionSwift', :git => 'git@github.com:adobe/aepsdk-sample-extension-ios.git', :branch => 'main'

    # install the ObjC extension
    pod 'AEPSampleExtensionObjC', :git => 'git@github.com:adobe/aepsdk-sample-extension-ios.git', :branch => 'main'    
end
```

## Development

#### Swift

- Navigate to the `Swift` directory, and run the following command from terminal:

    ```
    pod install
    ```

- After the above command finishes, open the Xcode workspace:

    ```
    open AEPSampleExtensionSwift.xcworkspace
    ```

#### Objective-c

- Navigate to the `ObjC` directory, and run the following command from terminal:

    ```
    pod install
    ```

- After the above command finishes, open the Xcode workspace:

    ```
    open AEPSampleExtensionObjC.xcworkspace
    ```

## Contributing

Contributions are welcomed! Read the [Contributing Guide](./.github/CONTRIBUTING.md) for more information.

## Licensing

This project is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
