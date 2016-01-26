//
//  ToDoItem.h
//  Every.do
//
//  Created by Carl Udren on 1/26/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *itemDescription;
@property (assign, nonatomic) NSInteger priority;
@property (assign, nonatomic) BOOL isCompleted;

+ (instancetype) ToDoItemWithTitle: (NSString *)title description:(NSString *) itemDescription priority: (NSInteger) priority;

@end
