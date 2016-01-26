//
//  ItemTableViewCell.m
//  Every.do
//
//  Created by Carl Udren on 1/26/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import "ItemTableViewCell.h"

@interface ItemTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) NSInteger priority;
@property (assign, nonatomic) BOOL isCompleted;

@end

@implementation ItemTableViewCell


- (void)configureCellForEntry:(ToDoItem *)item{
    self.titleLabel.text = item.title;
    if (item.isCompleted) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
}


@end
