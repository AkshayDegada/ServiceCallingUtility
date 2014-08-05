ServiceCallingUtility
=====================

Calling POST and GET web services. With Image and Files data.

For using this Utility in your xcode project.

Follow below steps:

1) Add ServiceCallingUtitliy File in your xcode project and make sure you check copy file if needed.

2) #import "ServiceCallingUtility.h" add this line where you want to call post or get web service.

3) Add below code for calling web service:

  -> Add parameter in array which you want to call.
    
    NSMutableArray * paramArray = [[NSMutableArray alloc] init];
    
    // Text Type Parameter. 
    [paramArray addObject:[ServiceParameter getTextParameterKey:@"<parameter-key>" andValue:@"<parameter-value as NSString>"]];
    
    // Image type Parameter.
    [paramArray addObject:[ServiceParameter getImageParameterKey:@"<parameter-key>" withValue:@"<parameter-value as UIImage>" andFileName:@"<file-name>"]];
    
    // File type Parameter.
    [paramArray addObject:[ServiceParameter getFileParameterKey:@"<parameter-key>" withValue:@"<parameter-value as NSData>" andFileName:@"<file-name>"]];
    
    // Direct HTTP Body Parameter
    [paramArray addObject:[ServiceParameter getDirectHTTPPostBody:<parameter-value as id> withContentType:<parameter-ContentType as NSString> andTimeOutTime:<Timeout Time in Seconds as NSInteger>]];
    
    
  -> After adding parameters you can procceed to call request. Below code will call request asyncronus.
  
    ServiceCallingUtility * objCallService = [[ServiceCallingUtility alloc] init];
    objCallService.delegate = self;
    
    // this flag will enable Debuge Mode 
    objCallService.isEnableDebugMode = YES;
    
    // this flag used for send data in direct http post body with out any key. 
    objCallService.sendDirectHTTPBody = NO;
    [objCallService doWebserviceCall:@"<URL-String>" withPostVars:<Post-Param-Array> withGetVars:<Get-Param-Array> andNotificationName:@"<Identifire-Key>"];
    
  Note: if you want to send only post parameters then you can pass "nil" in get parameters or visa versa.
  
  After calling web services below are two delegate methods which invoke.
  
  When Connection Finish with Success:
    
    - (void) didSuccessRequest:(NSString *) notification withResponse:(NSString *) response;
    
  When Coonection Failed with Error:
    
    - (void) didFailedRequest:(NSString *) notification withError:(NSError *) error;
    
  If you want to show upload request progress then implement below delegate:
  
    - (void) didSendRequest:(NSString *)notification progressPercentage:(CGFloat)percentage;
    

  
