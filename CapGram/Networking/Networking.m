//
//  Networking.m
//  DTransport
//
//  Created by Prasad Pamidi on 8/18/14.
//  Copyright (c) 2014 Disney. All rights reserved.
//

#import "Networking.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "Reachability.h"
#import "Configuration.h"

static Reachability *reachability;
@implementation Networking

+(void)startNetworkMonitor {
    if (!reachability) {
        reachability = [Reachability reachabilityForInternetConnection];
    }
    [reachability startNotifier];
}

// Check for reachability internet status
+ (DTNetworkStatus)networkStatus {
    if (!reachability) {
        reachability = [Reachability reachabilityForInternetConnection];
    }
    
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    if (networkStatus == ReachableViaWWAN) { // Check cellular network connection*/
        
        return NetworkReachable;
    }
    
    if (networkStatus == ReachableViaWiFi) { // Check Wifi network connection

//        if ([Networking isConnectedToRightNetwork] == NO) { // Check WLAN-TWDC connection
//            return WifiNotConnectedToRightSSID;
//        }
        
        return NetworkReachable;
    }
    
    return WifiNotReachable;
}


+ (BOOL)isConnectedToRightNetwork {
    CFArrayRef supportedInterfaces = CNCopySupportedInterfaces();
    if (supportedInterfaces) {
        NSArray* interfaces = (__bridge NSArray*)supportedInterfaces;
        
        CFRelease(supportedInterfaces);
        
        for (NSString *interfaceName in interfaces) {
            CFDictionaryRef interfaceDict = CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName);
            NSDictionary*  infoDict = (__bridge NSDictionary*)interfaceDict;
            
            if (infoDict) {
                NSString* info = infoDict[@"SSID"];
                CFRelease(interfaceDict);
                
                if ([info isEqualToString:@"WLAN-TWDC"]) { // Check for SSID read from configuration plist
                    
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

@end
