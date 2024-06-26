# Amani SDK #
![AmaniSDKHeader](https://user-images.githubusercontent.com/75306240/187692421-e595417a-95fd-4690-a4e3-6bb5af16d77e.png)


# Table of Content
- [Overview](#overview)
- [Basics](#basics)
    - [General Requirements](#general-requirements)
    - [Permissions](#permissions)
    - [Integration](#integration)
- [Installation](#Installation)
    - [Via CocoaPods](#via-cocoaPods)


# Overview

The Amani Software Development kit (SDK) provides you complete steps to perform KYC.This sdk consists of 5 steps:

## 1. Upload Your Identification:  

This internally consist of 4 types of documents, you can upload any of them to get your identification verified.THese documets are
1. Turkish ID Card(New): There you can upload your new turkish ID card.
2. Turkish ID Card(Old): There you can upload your old turkish ID card.
3. Turkish Driver License: There you can upload your old turkish driver license.
4. Passport: You can also upload your passport to get verification of your identity.

## 2. Upload your selfie:

This steps includes the taking a selfie and uploading it.


## 3. Upload Your Proof of Address:

There we have 4 types of categories you can upload any of them to get your address verified.  
1. Proof of Address: you will upload simply proof of address there.  
2. ISKI: you will upload ISKI address proof there.  
3. IGDAS: There you have the option of IGDAS.  
4. CK Bogazici Elektrik: You have to upload the same here.  

## 4. Sign Digital Contract:

In this step, you will enter your information required to make digital contract.Then you will got your contract in the same step from our side.Then by reading that contract, you have to sign that and then at the end upload the same.

## 5. Upload Physical Contract:

In this step, you will download your physical contract. Then you have to upload the same contrat by filling the all the information to get your physical contract verified.

## Congratulation Screen:

After successfully uploading of all the documents you will see a congratulation screen saying you completed all the steps.We will check your documents and
increase your limit in 48 hours.

# Basics

## General Requirements
The minimum requirements for the SDK are:  
* iOS 11.0 and higher  


### App permissions

Amani SDK makes use of the device Camera, Location and NFC. If you dont want to use location service please provide in init method. You will be required to have the following keys in your application's Info.plist file:

```xml
<key>com.apple.developer.nfc.readersession.iso7816.select-identifiers</key>
	<array>
		<string>A0000002471001</string>
	</array>
	<key>NFCReaderUsageDescription</key>
	<string>This application requires access to NFC to  scan IDs.</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>This application requires access to your location to upload the document.</string>
	<key>NSCameraUsageDescription</key>
	<string>This application requires access to your camera for scanning and uploading the document.</string>
```
**Note**: All keys will be required for app submission.

### Grant accesss to NFC
Enable the Near Field Communication Tag Reading capability in the target Signing & Capabilities. 


## Integration

##### Example Usage
Add Navigation Controller from XCode menu in Editor -> Embed in -> Navigation Controller
After embedded in then call our sdk

##### Swift

```swift

import UIKit
import Amani

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

	// Customer login information
        let customerModel = CustomerRequestModel(name: "CUSTOMER_NAME", email: "CUSTOMER_EMAIL", phone: "CUSTOMER_PHONE_NUMBER", idCardNumber: "CUSTOMER_ID_CARD")
	// Initialize SDK 
        let amaniSDK = AmaniSDK.sharedInstance
	// Configure SDK 
	amaniSDK.setDelegate(delegate: self)
	amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer)
	/*
	if dont want to use location permissions please provide with useGeoLocation parameter
	amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,useGeoLocation: false)

	select showing language with language parameter
	amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,language: "tr")
	
	
	amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,useGeoLocation: false,language: "tr")
*/
	// Start SDK 
        amaniSDK.showSDK(overParent: self)
    }


}


```

# Installation

## Via CocoaPods

Install using [CocoaPods](http://cocoapods.org) by adding this line to your Podfile:

Add sdk source to cocoapods 

```ruby
source "https://github.com/AmaniTechnologiesLtd/Mobile_SDK_Repo"
source "https://github.com/CocoaPods/Specs"
```

```ruby
use_frameworks!
  pod 'Amani'
```
also add after last end statement of podfile 

```ruby
#add following lines end of podfile after last 'end'
post_install do |installer|     
  installer.pods_project.build_configurations.each do |config|
#if you have intel Mac you need to comment out following line 
    #config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end
end
```

Then, run the following command:

```bash
$ pod install
```

## Getting Results 

## Event-Fire Callback ##
Event fire mechanism returns you as a simple callback. This callback contains string value of; EventType, EventName, EventParams. 

### Event Types ###
We are currently supporting two types of event.
  * ButtonPressed
  * Upload
  
### Event Names ###
We are currently supporting different kind of names. 

  * ManualCrop
  * Upload  
  * TryAgain
  * TakePhoto
  * OpenCameraButton
  * Clear
  * UploadButton
  * DownloadButton
  * WithNFC
  * ReadBtn
  * Continuebtn
  * Error
  
  ### Event Params ###
  We are currently supporting different kind of params. EventParams might be response of upload as string ("OK","ERROR"), "BackSide", "FrontSide" of documents.

    
    
###### Swift

```swift
extension ViewController:AmaniSDKDelegate{
    func onConnectionError(error: String?) {
        //do whatever when connection error
    }
    func onNoInternetConnection() {
        //do whatever when no internet connection
    }
    func onEvent(name: String, Parameters: [String]?, type: String) {
    	/*
    	//type // Type returns list of EventType
	//name // Amani Event Name. If there is more than one document, 
		returns the type of that document group else returns the type of the document 
		(the document type returns to you according to Amani standards).
		
	//parameter // Parameter returns Response, Error of upload. 
			If there is available it shows which step (like "0" front, "1" back) 
			(log: "XXX_SG_0", ["Continuebtn","0"], "buttonpressed" )
	*/
        print("log : \(name), \(Parameters), \(type)")
    }
    func onKYCSuccess(CustomerId: Int) {
        //do whatever when customer approved
    }

    func onKYCFailed(CustomerId: Int, Rules: [[String : String]]?) {
        // Returns uncompleted fields
    }

    func onTokenExpired() {
    	// returns when token expired. Token needs to be refreshed and restart instance 
    }
}
```
