//
//  ToDoItem.h
//  Every.do
//
//  Created by Carl Udren on 2/3/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int16_t, priority) {
    complete = 0,
    high = 2,
    low = 1
};

@interface ToDoItem : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "ToDoItem+CoreDataProperties.h"
