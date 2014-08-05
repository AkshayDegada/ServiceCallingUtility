//
//  ServiceCallingUtility.m
//  test
//
//  Created by Minesh Purohit on 31/07/14.
//  Copyright (c) 2014 MinuMaster. All rights reserved.
//

#import "ServiceCallingUtility.h"

@implementation ServiceCallingUtility

@synthesize delegate, isEnableDebugMode, sendDirectHTTPBody;

- (void) doWebserviceCall:(NSString *)action withPostVars:(NSArray *)post_vars withGetVars:(NSArray *)get_vars andNotificationName:(NSString *) notificationName
{
    notification = notificationName;
    responseData = [[NSMutableData alloc] init];
    
    // Add Method Action in URL.
	NSString *url_string = action;
    
	//adding get vars in url.
	if ( (get_vars != nil) && ([get_vars count] > 0) )
	{
        url_string = [NSString stringWithFormat:@"%@?",url_string];
		for (id param in get_vars)
        {
            if (![param isKindOfClass:[ServiceParameter class]]) {
                NSLog(@"Web Service Only Accept \"ServiceParameter\" Objects.");
                return;
            }
            if ([(ServiceParameter *)param valueType] != SCTypeText) {
                NSLog(@"Get Parameters Only Accept \"SCTypeText\" type parameters.");
                return;
            }
			url_string = [NSString stringWithFormat:@"%@%@=%@&", url_string, ((ServiceParameter *)param).key, (NSString *)((ServiceParameter *)param).value];
			
		}//end while
        
        url_string = [url_string substringToIndex:url_string.length-(url_string.length>0)];
        
	}//end if
    
    if (isEnableDebugMode) {
        NSLog(@"Get URL String:%@",url_string);
    }
    
    NSMutableURLRequest *postRequest =  [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	
	// change type to POST (default is GET)
	[postRequest setHTTPMethod:@"POST"];
    
    //adding get vars in url.
	if ( (post_vars != nil) && ([post_vars count] > 0) )
	{
        if (sendDirectHTTPBody)
        {
            if ([post_vars count] > 1) {
                NSLog(@"Direct HTTP Post body only accept One Service Parameter object.");
                return;
            }
            
            if ([post_vars count] > 0)
            {
                id param = [post_vars objectAtIndex:0];
                if (![((ServiceParameter *)param).value isKindOfClass:[NSData class]])
                {
                    NSLog(@"Direct HTTP Post body only accept NSData object.");
                    return;
                }
                
                if (((ServiceParameter *)param).contentType == nil)
                {
                    NSLog(@"Direct HTTP Post must have content type value.");
                    return;
                }
                
                if ([((ServiceParameter *)param).contentType length] <= 0)
                {
                    NSLog(@"Direct HTTP Post must have content type value.");
                    return;
                }
                
                if (((ServiceParameter *)param).timeoutTime <= 0) {
                    ((ServiceParameter *)param).timeoutTime = 15;
                }
                
                [postRequest setHTTPBody:((ServiceParameter *)param).value];
                [postRequest addValue:((ServiceParameter *)param).contentType forHTTPHeaderField:@"Content-Type"];
                [postRequest setTimeoutInterval:((ServiceParameter *)param).timeoutTime];
                
                _intRequestDataSize = [(NSData *)((ServiceParameter *)param).value length];
            }
        }
        else
        {
            // just some random text that will never occur in the body
            NSString *stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
            
            // header value
            NSString *headerBoundary = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",stringBoundary];
            
            // set header
            [postRequest addValue:headerBoundary forHTTPHeaderField:@"Content-Type"];
            
            // create data
            NSMutableData *postBody = [NSMutableData data];
            
            for (id param in post_vars)
            {
                if (![param isKindOfClass:[ServiceParameter class]]) {
                    NSLog(@"Web Service Only Accept \"ServiceParameter\" Objects.");
                    return;
                }
                
                if ([(ServiceParameter *)param valueType] == SCTypeText)
                {
                    // Send Text Value in Key
                    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",((ServiceParameter *)param).key] dataUsingEncoding:NSUTF8StringEncoding]];
                    [postBody appendData:[((ServiceParameter *)param).value dataUsingEncoding:NSUTF8StringEncoding]];
                    [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                }
                else if ([(ServiceParameter *)param valueType] == SCTypeImage)
                {
                    // Send Image Value in Key with Name
                    if ([((ServiceParameter *)param).value isKindOfClass:[UIImage class]])
                    {
                        NSString * fileNameValue = [ServiceParameter getTextFromString:((ServiceParameter *)param).fileName];
                        if ([fileNameValue length] > 0)
                        {
                            NSMutableArray * fileNameObject = [NSMutableArray arrayWithArray:[fileNameValue componentsSeparatedByString:@"."]];
                            [fileNameObject removeLastObject];
                            
                            NSString * newFileName = [NSString stringWithFormat:@"%@.jpg",[fileNameObject componentsJoinedByString:@"."]];
                            
                            [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
                            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", ((ServiceParameter *)param).key, newFileName] dataUsingEncoding:NSUTF8StringEncoding]];
                            [postBody appendData:[@"Content-Type: image/jpeg\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                            [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                            NSData * imageData = UIImageJPEGRepresentation(((ServiceParameter *)param).value, .9);
                            [postBody appendData:imageData];
                            [postBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                        }
                        else
                        {
                            NSLog(@"File Name required for type \"SCTypeImage\".");
                            return;
                        }
                    }
                    else
                    {
                        NSLog(@"Service Parameter Type \"SCTypeImage\" value only accept UIImage object.");
                        return;
                    }
                }
                else if ([(ServiceParameter *)param valueType] == SCTypeFile)
                {
                    if ([((ServiceParameter *)param).value isKindOfClass:[NSData class]])
                    {
                        // File Data Part
                        
                        NSString * fileNameValue = [ServiceParameter getTextFromString:((ServiceParameter *)param).fileName];
                        if ([fileNameValue length] > 0)
                        {
                            NSString * contentType = [ServiceParameter getContentTypeForExtension:[[fileNameValue componentsSeparatedByString:@"."] lastObject]];
                            
                            if ([contentType length] > 0)
                            {
                                [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
                                [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", ((ServiceParameter *)param).key,((ServiceParameter *)param).fileName] dataUsingEncoding:NSUTF8StringEncoding]];
                                [postBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n",contentType] dataUsingEncoding:NSUTF8StringEncoding]];
                                [postBody appendData:[@"Content-Transfer-Encoding: binary\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                                [postBody appendData:((ServiceParameter *)param).value];
                                
                                [postBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                            }
                            else
                            {
                                NSLog(@"Invalid File Name for type \"SCTypeFile\".");
                                return;
                            }
                        }
                        else
                        {
                            NSLog(@"File Name required for type \"SCTypeFile\".");
                            return;
                        }
                    }
                    else
                    {
                        NSLog(@"Service Parameter Type \"SCTypeFile\" value only accept NSData object.");
                        return;
                    }
                }
                else
                {
                    NSLog(@"Service Parameter Invalid valueType.");
                    return;
                }
            }//end while
            
            // final boundary
            [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //NSLog(@"%@",postBody);
            
            // add body to post
            [postRequest setHTTPBody:postBody];
            
            _intRequestDataSize = [postBody length];
        }
        
	}//end if
	
	// Asynch request
	NSURLConnection *conn = [NSURLConnection connectionWithRequest:postRequest delegate:self];
	if (!conn)
	{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"SC Connection" message:@"Connection Failed. Please try again." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
	}
    else
    {
        [conn start];
    }
    
}

#pragma mark - NSURLConnection delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([delegate respondsToSelector:@selector(didFailedRequest:withError:)])
    {
        [delegate didFailedRequest:notification withError:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if ([delegate respondsToSelector:@selector(didSuccessRequest:withResponse:)])
    {
        [delegate didSuccessRequest:notification withResponse:responseString];
    }
}

#pragma mark - NURLConnection Progress Methods

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
    if ([delegate respondsToSelector:@selector(didSendRequest:progressPercentage:)])
    {
        // Calculate Completion Percentage
		CGFloat fltComplete = 0;
		if (totalBytesExpectedToWrite > 0) {
			fltComplete = (1.0 * totalBytesWritten) / (1.0 * totalBytesExpectedToWrite);
		} else if (_intRequestDataSize > 0) {
			fltComplete = (1.0 * totalBytesWritten) / (1.0 * _intRequestDataSize);
		}
        
        [delegate didSendRequest:notification progressPercentage:fltComplete];
    }

}


#pragma mark - NURLConnection Authentication Methods

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
		[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

#pragma mark -

@end
