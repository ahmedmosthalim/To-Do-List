//
//  DoneViewController.m
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import "DoneViewController.h"
#import "ToDoAttributes.h"
#import "ToDoViewController.h"
#import "AppDelegate.h"
#import "ToDoFilteredDoneDetailsViewController.h"

@interface DoneViewController ()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
    NSArray *results;
    NSMutableArray *filteredTitle;
    NSMutableArray *filteredPriority;
    NSMutableArray *filteredDescription;
    NSMutableArray *filteredDates;
}
@end

@implementation DoneViewController
- (void)viewWillAppear:(BOOL)animated
{
    appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
    results = [context executeFetchRequest:request error:NULL];
    filteredTitle = [NSMutableArray new];
    filteredPriority= [NSMutableArray new];
    filteredDates= [NSMutableArray new];
    filteredDescription= [NSMutableArray new];
    for(int i=0; i<[results count] ;i++)
    {
        if( [[[results objectAtIndex:i]valueForKey:@"done"]  isEqual:  @"Yes"])
        {
            [filteredTitle addObject: [[results objectAtIndex:i] valueForKey:@"title"]];
            [filteredPriority addObject: [[results objectAtIndex:i] valueForKey:@"priority"]];
            [filteredDates addObject:[[results objectAtIndex:i]valueForKey:@"date"]];
            [filteredDescription addObject:[[results objectAtIndex:i]valueForKey:@"discription"]];
        }
    }
    self.navigationItem.title =@"Done List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SORT" style:UIBarButtonItemStylePlain target:self action:@selector(sortByPriority)];
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"sort40"] ;
    [self.tableview reloadData];
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
    results = [context executeFetchRequest:request error:NULL];
    filteredTitle = [NSMutableArray new];
    filteredPriority= [NSMutableArray new];
    filteredDates= [NSMutableArray new];
    filteredDescription= [NSMutableArray new];
    for(int i=0; i<[results count] ;i++)
    {
        if( [[[results objectAtIndex:i]valueForKey:@"done"]  isEqual:  @"Yes"])
        {
            [filteredTitle addObject: [[results objectAtIndex:i] valueForKey:@"title"]];
            [filteredPriority addObject: [[results objectAtIndex:i] valueForKey:@"priority"]];
            [filteredDates addObject:[[results objectAtIndex:i]valueForKey:@"date"]];
            [filteredDescription addObject:[[results objectAtIndex:i]valueForKey:@"discription"]];
        }
    }
    [super viewDidLoad];
    self.navigationItem.title =@"Done List";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SORT" style:UIBarButtonItemStylePlain target:self action:@selector(sortByPriority)];
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"sort40"] ;
    [self.tableview reloadData];
    // Do any additional setup after loading the view.
}
-(void)sortByPriority
{
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return filteredTitle.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *title =[cell viewWithTag:1];
    UILabel *priority =[cell viewWithTag:2];
    UIImageView *status = [cell viewWithTag:3];
    title.text = [filteredTitle objectAtIndex:indexPath.row];
    priority.text = [filteredPriority objectAtIndex:indexPath.row];
    status.image = [UIImage imageNamed:@"Todo"];
    if([[filteredPriority objectAtIndex:indexPath.row]  isEqual: @"Low"])
    {
        priority.backgroundColor = [UIColor greenColor];
    }else if ([[filteredPriority objectAtIndex:indexPath.row]  isEqual: @"High"])
    {
        priority.backgroundColor = [UIColor redColor];
    }else
    {
        priority.backgroundColor
        = [UIColor yellowColor];
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ToDoFilteredDoneDetailsViewController *objVC = [self.storyboard instantiateViewControllerWithIdentifier:@"toDoFilteredDoneDetailsVC"];
    objVC.str = [filteredTitle objectAtIndex:indexPath.row];
    objVC.titles = filteredTitle;
    objVC.priority = filteredPriority;
    objVC.dates = filteredDates;
    objVC.descs = filteredDescription;
    objVC.indexpath = indexPath.row;
    [self.navigationController pushViewController:objVC animated:YES];
    [self.tableview reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
            context = appDelegate.persistentContainer.viewContext;
            NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
            results = [context executeFetchRequest:request error:NULL];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are You Want To delete It ?"
                                                                                         message:@"Deleted data can not be restored"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                //We add buttons to the alert controller by creating UIAlertActions:
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                self->results = [self->context executeFetchRequest:request error:NULL];
                for(int i =0;i<[self->results count];i++)
            {
                if([[[self->results objectAtIndex:i] valueForKey:@"title"] isEqual:[self->filteredTitle objectAtIndex:indexPath.row]])
                {
                    NSManagedObject* favoritsGrabbed = [self->results objectAtIndex:i];
                    [self->context deleteObject:favoritsGrabbed];
                    [self->appDelegate saveContext];
                     NSError *error = nil;
                    if (![self->context save:&error]) {
                         NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                     }
                }
                
            }
                [self->filteredTitle removeObjectAtIndex:indexPath.row];
                [self->filteredDescription removeObjectAtIndex:indexPath.row];
                [self->filteredDates removeObjectAtIndex:indexPath.row];
                [self->filteredPriority removeObjectAtIndex:indexPath.row];
[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
       [self.tableview reloadData];
               
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
            //You can use a block here to handle a press on this button
                [alertController addAction:actionOk];
                [alertController addAction:cancel];
                [self presentViewController:alertController animated:YES completion:nil];
}
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
