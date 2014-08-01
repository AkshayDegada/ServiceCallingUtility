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
    
    
    
  -> After adding parameters you can procceed to call request. Below code will call request asyncronus.
  
    ServiceCallingUtility * objCallService = [[ServiceCallingUtility alloc] init];
    objCallService.delegate = self;
    objCallService.isEnableDebugMode = YES;
    [objCallService doWebserviceCall:@"<URL-String>" withPostVars:<Post-Param-Array> withGetVars:<Get-Param-Array> andNotificationName:@"<Identifire-Key>"];
    
  Note: if you want to send only post parameters then you can pass "nil" in get parameters or visa versa.
  
  
