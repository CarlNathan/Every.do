//
//  DetailViewController.h
//  Every.do
//
//  Created by Carl Udren on 1/26/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@protocol toDoDetailDelegate <NSObject>

- (void) insertToDoItemWithToDoItem: (ToDoItem *) item;

@end

@interface DetailViewController : UIViewController

@property (strong, nonatomic) ToDoItem *toDoItem;
@property (strong, nonatomic) id <toDoDetailDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UISwitch *completedSwitch;
@property (weak, nonatomic) IBOutlet UIButton *priorityButton;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
- (IBAction)setPriority:(UIButton *)sender;


- (IBAction)doneWasPressed:(UIBarButtonItem *)sender;
- (IBAction)cancelWasPressed:(UIBarButtonItem *)sender;
- (IBAction)switchWasToggled:(UISwitch *)sender;

@end

