//
//  ServiceParameter.m
//  test
//
//  Created by Minesh Purohit on 31/07/14.
//  Copyright (c) 2014 MinuMaster. All rights reserved.
//

#import "ServiceParameter.h"

@implementation ServiceParameter

@synthesize value, key, valueType, fileName, contentType, timeoutTime;


+ (ServiceParameter *) getTextParameterKey:(NSString *) key andValue:(id) value
{
    ServiceParameter * paramObj = [[ServiceParameter alloc] init];
    paramObj.key = key;
    paramObj.value = value;
    paramObj.valueType = SCTypeText;
    return paramObj;
}

+ (ServiceParameter *) getImageParameterKey:(NSString *) key withValue:(id) value andFileName:(NSString *) fileName
{
    ServiceParameter * paramObj = [[ServiceParameter alloc] init];
    paramObj.key = key;
    paramObj.value = value;
    paramObj.fileName = fileName;
    paramObj.valueType = SCTypeImage;
    return paramObj;
}

+ (ServiceParameter *) getFileParameterKey:(NSString *) key withValue:(id) value andFileName:(NSString *) fileName
{
    ServiceParameter * paramObj = [[ServiceParameter alloc] init];
    paramObj.key = key;
    paramObj.value = value;
    paramObj.fileName = fileName;
    paramObj.valueType = SCTypeFile;
    return paramObj;
}


+ (ServiceParameter *) getDirectHTTPPostBody:(id) value withContentType:(NSString *) contentType andTimeOutTime:(NSInteger) timeOut
{
    ServiceParameter * paramObj = [[ServiceParameter alloc] init];
    paramObj.value = value;
    paramObj.contentType = contentType;
    paramObj.timeoutTime = timeOut;
    return paramObj;
}


+ (NSString *) getContentTypeForExtension:(NSString *) extension
{
    NSMutableDictionary *dicMime = [[NSMutableDictionary alloc]init];
    [dicMime setValue:@".caf" forKey:@"audio/x-caf"];
    [dicMime setValue:@".afl" forKey:@"video/animaflex"];
    [dicMime setValue:@".aif" forKey:@"audio/aiff"];
    [dicMime setValue:@".aif" forKey:@"audio/x-aiff"];
    [dicMime setValue:@".aifc" forKey:@"audio/aiff"];
    [dicMime setValue:@".aifc" forKey:@"audio/x-aiff"];
    [dicMime setValue:@".aiff" forKey:@"audio/aiff"];
    [dicMime setValue:@".aiff" forKey:@"audio/x-aiff"];
    [dicMime setValue:@".aip" forKey:@"text/x-audiosoft-intra"];
    [dicMime setValue:@".art" forKey:@"image/x-jg"];
    [dicMime setValue:@".asf" forKey:@"video/x-ms-asf"];
    [dicMime setValue:@".asm" forKey:@"text/x-asm"];
    [dicMime setValue:@".asp" forKey:@"text/asp"];
    [dicMime setValue:@".asx" forKey:@"video/x-ms-asf"];
    [dicMime setValue:@".asx" forKey:@"video/x-ms-asf-plugin"];
    [dicMime setValue:@".au" forKey:@"audio/basic"];
    [dicMime setValue:@".au" forKey:@"audio/x-au"];
    [dicMime setValue:@".avi" forKey:@"video/avi"];
    [dicMime setValue:@".avi" forKey:@"video/msvideo"];
    [dicMime setValue:@".avi" forKey:@"video/x-msvideo"];
    [dicMime setValue:@".avs" forKey:@"video/avs-video"];
    [dicMime setValue:@".bm" forKey:@"image/bmp"];
    [dicMime setValue:@".bmp" forKey:@"image/bmp"];
    [dicMime setValue:@".bmp" forKey:@"image/x-windows-bmp"];
    [dicMime setValue:@".c" forKey:@"text/plain"];
    [dicMime setValue:@".c" forKey:@"text/x-c"];
    [dicMime setValue:@".c++" forKey:@"text/plain"];
    [dicMime setValue:@".cc" forKey:@"text/plain"];
    [dicMime setValue:@".cc" forKey:@"text/x-c"];
    [dicMime setValue:@".com" forKey:@"text/plain"];
    [dicMime setValue:@".conf" forKey:@"text/plain"];
    [dicMime setValue:@".cpp" forKey:@"text/x-c"];
    [dicMime setValue:@".csh" forKey:@"text/x-script.csh"];
    [dicMime setValue:@".css" forKey:@"text/css"];
    [dicMime setValue:@".cxx" forKey:@"text/plain"];
    [dicMime setValue:@".def" forKey:@"text/plain"];
    [dicMime setValue:@".dif" forKey:@"video/x-dv"];
    [dicMime setValue:@".dl" forKey:@"video/dl"];
    [dicMime setValue:@".dl" forKey:@"video/x-dl"];
    [dicMime setValue:@".dv" forKey:@"video/x-dv"];
    [dicMime setValue:@".dwg" forKey:@"image/vnd.dwg"];
    [dicMime setValue:@".dwg" forKey:@"image/x-dwg"];
    [dicMime setValue:@".dxf" forKey:@"image/vnd.dwg"];
    [dicMime setValue:@".dxf" forKey:@"image/x-dwg"];
    [dicMime setValue:@".el" forKey:@"text/x-script.elisp"];
    [dicMime setValue:@".fif" forKey:@"image/fif"];
    [dicMime setValue:@".fli" forKey:@"video/fli"];
    [dicMime setValue:@".fli" forKey:@"video/x-fli"];
    [dicMime setValue:@".flo" forKey:@"image/florian"];
    [dicMime setValue:@".fpx" forKey:@"image/vnd.fpx"];
    [dicMime setValue:@".gif" forKey:@"image/gif"];
    [dicMime setValue:@".hh" forKey:@"text/plain"];
    [dicMime setValue:@".ico" forKey:@"image/x-icon"];
    [dicMime setValue:@".jpe" forKey:@"image/jpeg"];
    [dicMime setValue:@".jpe" forKey:@"image/pjpeg"];
    [dicMime setValue:@".jpeg" forKey:@"image/jpeg"];
    [dicMime setValue:@".jpeg" forKey:@"image/pjpeg"];
    [dicMime setValue:@".jpg" forKey:@"image/jpeg"];
    [dicMime setValue:@".jpg" forKey:@"image/pjpeg"];
    [dicMime setValue:@".m" forKey:@"text/plain"];
    [dicMime setValue:@".m1v" forKey:@"video/mpeg"];
    [dicMime setValue:@".m2a" forKey:@"audio/mpeg"];
    [dicMime setValue:@".m2v" forKey:@"video/mpeg"];
    [dicMime setValue:@".m3u" forKey:@"audio/x-mpequrl"];
    [dicMime setValue:@".mid" forKey:@"audio/midi"];
    [dicMime setValue:@".mid" forKey:@"audio/x-mid"];
    [dicMime setValue:@".mid" forKey:@"audio/x-midi"];
    [dicMime setValue:@".mod" forKey:@"audio/mod"];
    [dicMime setValue:@".mov" forKey:@"video/quicktime"];
    [dicMime setValue:@".mp2" forKey:@"video/mpeg"];
    [dicMime setValue:@".mp2" forKey:@"audio/mpeg"];
    [dicMime setValue:@".mp3" forKey:@"audio/mpeg3"];
    [dicMime setValue:@".mpa" forKey:@"audio/mpeg"];
    [dicMime setValue:@".mpg" forKey:@"audio/mpeg"];
    [dicMime setValue:@".nif" forKey:@"image/x-niff"];
    [dicMime setValue:@".niff" forKey:@"image/x-niff"];
    [dicMime setValue:@".pdf" forKey:@"application/pdf"];
    [dicMime setValue:@".png" forKey:@"image/png"];
    [dicMime setValue:@".ppt" forKey:@"application/x-mspowerpoint"];
    [dicMime setValue:@".psd" forKey:@"application/octet-stream"];
    [dicMime setValue:@".qif" forKey:@"image/x-quicktime"];
    [dicMime setValue:@".rgb" forKey:@"image/x-rgb"];
    [dicMime setValue:@".s3m" forKey:@"audio/s3m"];
    [dicMime setValue:@".sid" forKey:@"audio/x-psid"];
    [dicMime setValue:@".svf" forKey:@"image/vnd.dwg"];
    [dicMime setValue:@".text" forKey:@"application/plain"];
    [dicMime setValue:@".text" forKey:@"text/plain"];
    [dicMime setValue:@".txt" forKey:@"text/plain"];
    [dicMime setValue:@".wav" forKey:@"audio/wav"];
    [dicMime setValue:@".word" forKey:@"application/msword"];
    [dicMime setValue:@".xif" forKey:@"image/vnd.xiff"];
    [dicMime setValue:@".xlm" forKey:@"application/excel"];
    [dicMime setValue:@".xls" forKey:@"application/vnd.ms-excel"];
    [dicMime setValue:@".z" forKey:@"application/x-compress"];
    [dicMime setValue:@".zip" forKey:@"application/x-compressed"];
    [dicMime setValue:@".csv" forKey:@"text/csv"];

    NSString *strEx = [NSString stringWithFormat:@".%@",extension];
    NSArray *temp = [dicMime allKeysForObject:[strEx lowercaseString]];
    
    NSString * contentType = @"";
    if ([temp count] > 0) {
        contentType = [temp objectAtIndex:0];
    }
    
    return contentType;
}

+ (NSString *) getTextFromString:(NSString *)strString
{
    NSString *strTemp =  @"";
    
    if (![strString isEqual:[NSNull null]])
    {
        if ([[strString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0)
        {
            strTemp = [strString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            return strTemp;
        }
    }
    return strTemp;
}

@end
