//
//  ToDoItem+CoreDataProperties.h
//  Every.do
//
//  Created by Carl Udren on 2/3/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *itemDescription;
@property (nonatomic) NSDate *date;
@property (nonatomic) int16_t priority;

@end

NS_ASSUME_NONNULL_END
