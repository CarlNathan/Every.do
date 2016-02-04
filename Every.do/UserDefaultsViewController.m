//
//  UserDefaultsViewController.m
//  Every.do
//
//  Created by Carl Udren on 2/3/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import "UserDefaultsViewController.h"

@interface UserDefaultsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
- (IBAction)saveWasPressed:(UIButton *)sender;

@end

@implementation UserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.titleLabel becomeFirstResponder];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    ToDoItem *item = [self.userDefaults objectForKey:@"defaultItem"];
    
    self.titleLabel.text = item.title;
    self.descriptionText.text = item.description;

}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.titleLabel resignFirstResponder];
    [self.descriptionText resignFirstResponder];
}

- (IBAction)saveWasPressed:(UIButton *)sender {
    
    NSString *title = self.titleLabel.text;
    NSString *description = self.descriptionText.text;
    
    NSDictionary *defaultDictionary = @{@"defaultTitle": title , @"defaultDescription":description};
    
    [self.userDefaults setObject:defaultDictionary forKey:@"defaultDictionary"];
    
    [self.userDefaults synchronize];

    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
