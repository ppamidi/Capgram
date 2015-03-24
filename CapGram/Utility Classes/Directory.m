//
//  Directory.m
//  Hercules
//
//  Created by Priyanka on 6/18/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import "Directory.h"

@implementation Directory

+ (NSString*)cachesDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSURL*)applicationCachesDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
