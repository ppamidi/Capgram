//
//  Configuration.h
//  Hercules
//
//  Created by Prasad Pamidi on 8/29/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Configuration : NSObject

+ (NSString*)getBaseURL;
+ (NSString*)getTransportationWSDLPath;

+ (NSString*)getAllLocationsSOAPActionURL;
+ (NSString*)getArrivalsSOAPActionURL;

+ (NSUInteger) getRequestTimeOutInterval;

@end
