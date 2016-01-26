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
    if (self.toDoItem) {
        self.titleTextField.text = self.toDoItem.title;
        self.descriptionTextView.text = self.toDoItem.itemDescription;
        if (self.toDoItem.isCompleted) {
            [self.completedSwitch setOn:YES animated:NO];
            [self setPriorityLow];
        } else {
            [self.completedSwitch setOn:NO animated:NO];
        }
        if (self.toDoItem.priority == high) {
            [self setPriorityHigh];
        } else if (self.toDoItem.priority == low){
            [self setPriorityLow];
        } else if (self.toDoItem.priority == complete){
            [self setPriorityComplete];
        }
    } else {
        [self.completedSwitch setOn:NO animated:NO];
        self.descriptionTextView.text = @"";
        [self setPriorityLow];
    }
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (IBAction)setPriority:(UIButton *)sender {
    if (!self.completedSwitch.on) {
        if ([self.priorityButton.titleLabel.text isEqualToString:@"High Priority"]) {
        [self setPriorityLow];
        } else {
            [self setPriorityHigh];
        }
    }
}

- (IBAction)doneWasPressed:(UIBarButtonItem *)sender {
        if (self.toDoItem !=nil) {
            [self updateToDoList];
        }else{
            
            [self insertToDoItem];
        }
        [self.navigationController.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cancelWasPressed:(UIBarButtonItem *)sender {
    [self.navigationController.navigationController popViewControllerAnimated:YES];
}

- (IBAction)switchWasToggled:(UISwitch *)sender {
    if (self.completedSwitch.on) {
        [self setPriorityComplete];
    } else {
        [self setPriorityLow];
    }
}

-(void)updateToDoList{
    self.toDoItem.title = self.titleTextField.text;
    self.toDoItem.itemDescription = self.descriptionTextView.text;
    if (self.completedSwitch.on) {
        self.toDoItem.isCompleted = YES;
    } else {
        self.toDoItem.isCompleted = NO;
    }
    if ([self.priorityButton.titleLabel.text isEqualToString:@"High Priority"]) {
        self.toDoItem.priority = high;
    } else if ([self.priorityButton.titleLabel.text isEqualToString:@"Low Priority"]){
        self.toDoItem.priority = low;
    } else {
        self.toDoItem.priority = complete;
    }
}

- (void) insertToDoItem{
    NSInteger priority;
    if ([self.priorityButton.titleLabel.text isEqualToString:@"High Priority"]) {
        priority = high;
    } else if ([self.priorityButton.titleLabel.text isEqualToString:@"Low Priority"]){
        priority = low;
    } else {
        priority = complete;
    }
    ToDoItem *item = [ToDoItem ToDoItemWithTitle:self.titleTextField.text description:self.descriptionTextView.text priority:priority];
    if (item.priority == complete){
        item.isCompleted = YES;
    }
    [self.delegate insertToDoItemWithToDoItem: item];
}

- (void) setPriorityLow {
    self.priorityButton.backgroundColor = [UIColor yellowColor];
    [self.priorityButton setTitle:@"Low Priority" forState: UIControlStateNormal];
}

- (void) setPriorityHigh{
        self.priorityButton.backgroundColor = [UIColor redColor];
        [self.priorityButton setTitle:@"High Priority" forState:UIControlStateNormal];
}

- (void) setPriorityComplete {
    self.priorityButton.backgroundColor = [UIColor greenColor];
    [self.priorityButton setTitle:@"Complete" forState:UIControlStateNormal];
}


- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.titleTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
}


@end
