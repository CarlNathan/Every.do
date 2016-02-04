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
#import "CoreDataStack.h"

@interface MasterViewController () <NSFetchedResultsControllerDelegate>

//@property NSMutableArray *objects;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //setup toDoList
//    ToDoItem *itemGroceries = [ToDoItem ToDoItemWithTitle:@"Get Groceries" description:@"Need to go to the store to get some food!" priority:high date:[NSDate date]];
//    ToDoItem *itemGetMoreExercise = [ToDoItem ToDoItemWithTitle:@"Exercise" description:@"Need to go to the gym more often!" priority:low date:[NSDate date]];
//    ToDoItem *itemGetGift = [ToDoItem ToDoItemWithTitle:@"Buy Gift" description:@"Need to go get a great birthday gift for some person whose birthday it is going to be!" priority:low date:[NSDate date]];
//
//    self.objects = [@[itemGroceries, itemGetMoreExercise, itemGetGift] mutableCopy];
    
    //navigation items
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    UISwipeGestureRecognizer *swipteComplete = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    swipteComplete.direction = UISwipeGestureRecognizerDirectionRight;
    [self.tableView addGestureRecognizer:swipteComplete];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.fetchedResultsController performFetch:nil];
}



- (void)insertNewObject:(id)sender {
    [self performSegueWithIdentifier:@"newItem" sender:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        //ToDoItem *object = self.objects[indexPath.row];
        ToDoItem *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.toDoItem = object;
    } else if ([[segue identifier] isEqualToString:@"newItem"]) {
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        controller.defaultDictionary = [userDefaults objectForKey:@"defaultDictionary"];

    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.objects.count;
    id <NSFetchedResultsSectionInfo> sectionsInfo = [self.fetchedResultsController sections][section];
    return [sectionsInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //ToDoItem *object = self.objects[indexPath.row];
    ToDoItem *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureCellForEntry:object];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[self.objects removeObjectAtIndex:indexPath.row];
        CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
        ToDoItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [[coreDataStack managedObjectContext] deleteObject:item];
        [coreDataStack saveContext];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
        //ToDoItem *item = (ToDoItem *) self.objects[indexPath.row];
        ToDoItem *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
        item.priority = complete;
        [self.tableView reloadData];
    }
    
}
#pragma Mark - Detail Delegate
//  Never used, core data save in detail view instead.
//- (void) insertToDoItemWithToDoItem: (ToDoItem *) item{
//    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
//    coreDataStack 
//}

#pragma Mark - FetchedResultsController Delegate

- (NSFetchRequest *)entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ToDoItem"];
    
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:NO],[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    return fetchRequest;
}

- (NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView reloadData];
            break;
    }
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}




@end
