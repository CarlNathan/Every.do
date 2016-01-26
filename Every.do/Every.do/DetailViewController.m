//
//  DetailViewController.m
//  Every.do
//
//  Created by Carl Udren on 1/26/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void)configureView {
    // Update the user interface for the detail item.
    self.titleTextField.text = self.toDoItem.title;
    self.descriptionTextView.text = self.toDoItem.itemDescription;
    if (self.toDoItem.isCompleted) {
        [self.completedSwitch setOn:YES animated:YES];
    } else {
        [self.completedSwitch setOn:NO animated:YES];
    }
    
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}




#pragma Mark - Table View Data Source


- (IBAction)doneWasPressed:(UIBarButtonItem *)sender {
        if (self.toDoItem !=nil) {
            [self updateToDoList];
        }else{
            
            [self insertToDoItem];
        }
        [self.navigationController.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cancelWasPressed:(UIBarButtonItem *)sender {
    NSLog(@"cancel was pressed");
    [self.navigationController.navigationController popViewControllerAnimated:YES];
}

-(void)updateToDoList{
    self.toDoItem.title = self.titleTextField.text;
    self.toDoItem.itemDescription = self.descriptionTextView.text;
    self.toDoItem.priority = 1;
    if (self.completedSwitch.on) {
        self.toDoItem.isCompleted = YES;
    } else {
        self.toDoItem.isCompleted = NO;
    }
}

- (void) insertToDoItem{
    ToDoItem *item = [ToDoItem ToDoItemWithTitle:self.titleTextField.text description:self.descriptionTextView.text priority:1];
    [self.delegate insertToDoItemWithToDoItem: item];
}
@end
