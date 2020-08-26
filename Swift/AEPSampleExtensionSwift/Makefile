# Variables
PROJECT_NAME = AEPSampleExtensionSwift

SIMULATOR_ARCHIVE_PATH = ./build/ios_simulator.xcarchive/Products/Library/Frameworks/
IOS_ARCHIVE_PATH = ./build/ios.xcarchive/Products/Library/Frameworks/

archive:
	xcodebuild archive -scheme $(PROJECT_NAME) -archivePath "./build/ios.xcarchive" -sdk iphoneos -destination="iOS" SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
	xcodebuild -create-xcframework -framework $(SIMULATOR_ARCHIVE_PATH)$(PROJECT_NAME).framework -framework $(IOS_ARCHIVE_PATH)$(PROJECT_NAME).framework -output ./build/$(PROJECT_NAME).xcframework