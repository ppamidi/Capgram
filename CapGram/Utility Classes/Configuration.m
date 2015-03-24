//
//  Configuration.m
//  Hercules
//
//  Created by Prasad Pamidi on 8/29/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import "Configuration.h"

static NSString* const kBaseURL = @"Base URL";
static NSString* const kTransportationWSDLPath = @"Transporation WSDL Path";
static NSString* const kGetAllLocationSOAPActionURL = @"GetAllLocations SOAPAction URL";
static NSString* const kGetArrivalsSOAPActionURL = @"GetArrivals SOAPAction URL";
static NSString* const kGetRequestTimeOutInterval = @"Request Timeout Interval";


@implementation Configuration

+ (NSString*)getBaseURL {
    return [[Configuration dictionary] objectForKey:kBaseURL];
}

+ (NSString*)getTransportationWSDLPath {
    return [[Configuration dictionary] objectForKey:kTransportationWSDLPath];
}

+ (NSString*)getAllLocationsSOAPActionURL {
    return [[Configuration dictionary] objectForKey:kGetAllLocationSOAPActionURL];
}

+ (NSString*)getArrivalsSOAPActionURL {
    return [[Configuration dictionary] objectForKey:kGetArrivalsSOAPActionURL];
}

+ (NSUInteger) getRequestTimeOutInterval {
     return [[[Configuration dictionary] objectForKey:kGetRequestTimeOutInterval] floatValue];
}

+ (NSString*)configurationFilePath {
    NSString *str = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"];
    if (str) {
        return str;
    }
    
    return nil;
}

+ (NSDictionary*)dictionary {
    static NSDictionary *dict = nil;
    if (dict == nil) {
        dict = [NSDictionary dictionaryWithContentsOfFile:[Configuration configurationFilePath]];
    }
    return dict;
}

@end
