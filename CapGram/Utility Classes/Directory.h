//
//  Directory.h
//  Hercules
//
//  Created by Priyanka on 6/18/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Directory : NSObject

+ (NSString*)cachesDirectory;
+ (NSURL*)applicationCachesDirectory;

@end
