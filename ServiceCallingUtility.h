//
//  ServiceCallingUtility.h
//  test
//
//  Created by Minesh Purohit on 31/07/14.
//  Copyright (c) 2014 Triforce Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ServiceParameter.h"

@protocol ServiceCallingUtilityDelegate <NSObject>

@optional
- (void) didFailedRequest:(NSString *) notification withError:(NSError *) error;
- (void) didSuccessRequest:(NSString *) notification withResponse:(NSString *) response;

@end

@interface ServiceCallingUtility : NSObject
{
    NSMutableData * responseData;
    NSString * notification;
    
    BOOL isEnableDebugMode;
    
    id <ServiceCallingUtilityDelegate> delegate;
}

@property (nonatomic, retain) NSString * notificationName;
@property (nonatomic, readwrite) BOOL isEnableDebugMode;
@property (nonatomic, retain) id <ServiceCallingUtilityDelegate> delegate;

-(void) doWebserviceCall:(NSString *)action withPostVars:(NSArray *)post_vars withGetVars:(NSArray *)get_vars andNotificationName:(NSString *) notificationName;

@end
