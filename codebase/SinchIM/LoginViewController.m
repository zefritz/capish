#import "LoginViewController.h"

#import "AppDelegate.h"

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.nameTextField becomeFirstResponder];
}

- (IBAction)onLoginButtonPressed:(id)sender {

  if ([self.nameTextField.text length] == 0) {
    return;
  }

  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  [appDelegate initSinchClientWithUserId:self.nameTextField.text];
  [self performSegueWithIdentifier:@"messagingView" sender:nil];
}

@end
