//
//  ToDoItem.m
//  Every.do
//
//  Created by Carl Udren on 1/26/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

+ (instancetype) ToDoItemWithTitle: (NSString *)title description:(NSString *) itemDescription priority: (NSInteger) priority date:(NSDate *)date{
    ToDoItem *item = [[ToDoItem alloc] init];
    item.date = date;
    item.title = title;
    item.itemDescription = itemDescription;
    item.priority = priority;
    item.isCompleted = NO;
    return item;
}

@end
