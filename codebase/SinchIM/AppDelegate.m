#import "AppDelegate.h"
#import "AppDelegate+UI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self addSplashView];
  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [self dismissSplashViewIfNecessary];
}

#pragma mark -

- (id<SINClient>)client {
  return _client;
}

- (void)initSinchClientWithUserId:(NSString *)userId {
  if (!_client) {
    _client = [Sinch clientWithApplicationKey:@"81027af3-14eb-4d7c-802d-518a0d1d38e7"
                            applicationSecret:@"HYnsI0dZakeKRGIT/CR5ig=="
                              environmentHost:@"sandbox.sinch.com"
                                       userId:userId];

    _client.delegate = self;

    [_client setSupportMessaging:YES];

    [_client start];
    [_client startListeningOnActiveConnection];
  }
}

#pragma mark - SINClientDelegate

- (void)clientDidStart:(id<SINClient>)client {
  NSLog(@"Sinch client started successfully (version: %@)", [Sinch version]);
}

- (void)clientDidStop:(id<SINClient>)client {
  NSLog(@"Sinch client stopped");
}

- (void)clientDidFail:(id<SINClient>)client error:(NSError *)error {
  NSLog(@"Error: %@", error);
}

- (void)client:(id<SINClient>)client
    logMessage:(NSString *)message
          area:(NSString *)area
      severity:(SINLogSeverity)severity
     timestamp:(NSDate *)timestamp {

  if (severity == SINLogSeverityCritical) {
    NSLog(@"%@", message);
  }
}

@end
