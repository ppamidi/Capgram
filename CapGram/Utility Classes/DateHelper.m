//
//  DateHelper.m
//  Hercules
//
//  Created by Priyanka on 6/18/13.
//  Copyright (c) 2013 Disney. All rights reserved.
//

#import "DateHelper.h"
#import "NSDate+Util.h"
#import "DLog.h"

@implementation DateHelper

+ (NSDateFormatter *)formatter {
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    return formatter;
}

// Get date from string with format "yyyy-MM-dd HH:mm"
+ (NSDate*)dateFromStringFormat1:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm"];
    
     return [formatter dateFromString:dateStr];
}

// Get date from string with format "yyyy-MM-dd HH:mm:ss"
+ (NSDate*)dateFromStringFormat2:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    return [formatter dateFromString:dateStr];
}

// Get date from string with format "yyyy-MM-dd"
+ (NSDate*)dateFromStringFormat3:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    return [[formatter dateFromString:dateStr] updateTimeToMidnight]; // This is to consider End of day time (23:59:59)
}

// Get date from string with format "yyyy-MM-dd"
+ (NSDate*)dateFromStringFormat4:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    return [formatter dateFromString:dateStr];
}

// Get date from string with format "yyyy-MM-dd"
+ (NSDate*)dateFromStringFormat5:(NSString*)dateStr {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"MM/dd"];
    return [formatter dateFromString:dateStr];
}

// Get string from date like format "MM/dd/yyyy"
+ (NSString*)stringFromDateFormat1:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    
     return [formatter stringFromDate:date];
}

// Get string from date like format "HH:mm"
+ (NSString*)getTimeFromDate:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"hh:mm a"];
    
    return [formatter stringFromDate:date];
}

// Get string from date like format "yyyy-MM-dd HH:mm:ss"
+ (NSString*)stringFromDateFormat2:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
    
    return [formatter stringFromDate:date];
}

// Get string from date like format "yyyy-MM-dd HH:mm:ss"
+ (NSString*)timeStringFromDate:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"HH:mm"];
  
    return [formatter stringFromDate:date];
}

// Get string from date like format "yyyy-MM-dd"
+ (NSString*)stringFromDateFormat3:(NSDate*)date {
    NSDateFormatter *formatter = [self formatter];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    return [formatter stringFromDate:date];
}


+ (BOOL)isToday:(NSDate*)date {
    NSDate * today = [NSDate date];
    NSComparisonResult result = [today compare:date];
    switch (result) {
        case NSOrderedAscending:
            return NO;
        case NSOrderedDescending:
            return YES;
        case NSOrderedSame:
            return YES;
        default:
            return NO;
    }
}

+ (int)daysBetween:(NSDate *)date1 and:(NSDate *)date2 {
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:unitFlags fromDate:date1 toDate:date2 options:0];
    
    return [[ NSNumber numberWithLong:[components day]] intValue] + 1;
}

+ (NSDate*)addDays:(NSInteger)noOfDays todate:(NSDate*)date {
    NSDate *newDate = [date dateByAddingTimeInterval: 60 * 60 * 24 * noOfDays];
    
    return newDate;
}

@end
