//
//  Localize.h
//  DTransport
//
//  Created by Prasad Pamidi on 8/11/14.
//  Copyright (c) 2014 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

static NSString* const kReaderNotDetected = @"Reader not detected";

@interface Localize : NSObject


@end
