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
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (assign, nonatomic) NSInteger priority;
@property (assign, nonatomic) BOOL isCompleted;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegmentedControl;

@end

@implementation ItemTableViewCell


- (void)configureCellForEntry:(ToDoItem *)item{
    self.titleLabel.text = item.title;
    self.descriptionLabel.text = item.itemDescription;
    if (item.isCompleted) {
        //strikethrough
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:item.title];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        self.titleLabel.attributedText = attributeString;
    } else {
        //nostrikethough
        self.titleLabel.text = item.title;
    }
    if (item.priority == high){
        //high priority
        self.prioritySegmentedControl.selectedSegmentIndex = 0;
        self.prioritySegmentedControl.alpha = 1;
        self.prioritySegmentedControl.userInteractionEnabled = NO;
    } else if (item.priority == low){
        //low priority
        self.prioritySegmentedControl.selectedSegmentIndex = 1;
        self.prioritySegmentedControl.alpha = 1;
        self.prioritySegmentedControl.userInteractionEnabled = NO;

    } else {
        self.prioritySegmentedControl.alpha = 0.25;
        self.prioritySegmentedControl.userInteractionEnabled = NO;
    }
}


@end
