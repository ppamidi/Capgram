//
//  Networking.h
//  DTransport
//
//  Created by Prasad Pamidi on 8/18/14.
//  Copyright (c) 2014 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, DTNetworkStatus) {
    NetworkReachable = 0,
    NetworkNotReachable,
    WifiNotReachable,
    WifiNotConnectedToRightSSID,
    ServerError
};

@interface Networking : NSObject
+(void)startNetworkMonitor;

+ (DTNetworkStatus)networkStatus;
+ (BOOL)isConnectedToRightNetwork;

@end
