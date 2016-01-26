//
//  ItemTableViewCell.h
//  Every.do
//
//  Created by Carl Udren on 1/26/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface ItemTableViewCell : UITableViewCell

- (void)configureCellForEntry:(ToDoItem *)item;


@end
