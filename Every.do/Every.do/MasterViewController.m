//
//  MasterViewController.m
//  Every.do
//
//  Created by Carl Udren on 1/26/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ToDoItem.h"
#import "ItemTableViewCell.h"

@interface MasterViewController () <toDoDetailDelegate>

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup toDoList
    ToDoItem *itemGroceries = [ToDoItem ToDoItemWithTitle:@"Get Groceries" description:@"Need to go to the store to get some food!" priority:high date:[NSDate date]];
    ToDoItem *itemGetMoreExercise = [ToDoItem ToDoItemWithTitle:@"Exercise" description:@"Need to go to the gym more often!" priority:low date:[NSDate date]];
    ToDoItem *itemGetGift = [ToDoItem ToDoItemWithTitle:@"Buy Gift" description:@"Need to go get a great birthday gift for some person whose birthday it is going to be!" priority:low date:[NSDate date]];

    self.objects = [@[itemGroceries, itemGetMoreExercise, itemGetGift] mutableCopy];
    
    //navigation items
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    UISwipeGestureRecognizer *swipteComplete = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    swipteComplete.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:swipteComplete];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    //sort descriptor
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"priority"
                                                 ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self.objects sortedArrayUsingDescriptors:sortDescriptors];
    self.objects = [sortedArray mutableCopy];

    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self performSegueWithIdentifier:@"newItem" sender:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDoItem *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.toDoItem = object;
        controller.delegate = self;
    } else if ([[segue identifier] isEqualToString:@"newItem"]) {
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.delegate = self;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ToDoItem *object = self.objects[indexPath.row];
    [cell configureCellForEntry:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 110.0;
}

- (void) didSwipeRight: (UISwipeGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    if (indexPath) {
        ToDoItem *item = (ToDoItem *) self.objects[indexPath.row];
        item.isCompleted = YES;
        item.priority = complete;
        [self.tableView reloadData];
    }
    
}
#pragma Mark - Detail Delegate

- (void) insertToDoItemWithToDoItem: (ToDoItem *) item{
    [self.objects addObject:item];
    [self.tableView reloadData];
}

@end
