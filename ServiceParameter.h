//
//  ServiceParameter.h
//  test
//
//  Created by Minesh Purohit on 31/07/14.
//  Copyright (c) 2014 Triforce Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    SCTypeText,
    SCTypeImage,
    SCTypeFile,

} MyEnum;

@interface ServiceParameter : NSObject
{
    id value;
    NSString * key;
    NSString * fileName;
    long valueType;
    NSString * contentType;
    
    // In Seconds.
    NSInteger timeoutTime;
}

@property (nonatomic,retain) id value;
@property (nonatomic,retain) NSString * key;
@property (nonatomic,retain) NSString * fileName;
@property (nonatomic,readwrite) long valueType;

+ (NSString *) getContentTypeForExtension:(NSString *) extension;
+ (NSString *) getTextFromString:(NSString *)strString;

+ (ServiceParameter *) getTextParameterKey:(NSString *) key andValue:(id) value;
+ (ServiceParameter *) getImageParameterKey:(NSString *) key withValue:(id) value andFileName:(NSString *) fileName;
+ (ServiceParameter *) getFileParameterKey:(NSString *) key withValue:(id) value andFileName:(NSString *) fileName;

+ (ServiceParameter *) getDirectHTTPPostBody:(id) value withContentType:(NSString *) contentType andTimeOutTime:(NSInteger) timeOut;

@end
