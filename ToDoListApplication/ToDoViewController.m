//
//  ToDoViewController.m
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import "ToDoViewController.h"
#import "AddToDoViewController.h"
#import "ToDoAttributes.h"
#import "AppDelegate.h"
#import "ToDoDetailsViewController.h"

@interface ToDoViewController ()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
    NSMutableArray *results;
    NSMutableArray *filteredTitle;
    NSMutableArray *filteredPriority;
    NSMutableArray *filteredDescription;
    NSMutableArray *filteredDates;
    BOOL isFiltered;
    NSMutableArray *sortedTitles;
    NSMutableArray *sortedPriority;
    NSMutableArray *sortedDescription;
    NSMutableArray *sortedDates;
}
@end

@implementation ToDoViewController

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
        if( [[[results objectAtIndex:i]valueForKey:@"done"]  isEqual:  @"not"])
        {
            [filteredTitle addObject: [[results objectAtIndex:i] valueForKey:@"title"]];
            [filteredPriority addObject: [[results objectAtIndex:i] valueForKey:@"priority"]];
            [filteredDates addObject:[[results objectAtIndex:i]valueForKey:@"date"]];
            [filteredDescription addObject:[[results objectAtIndex:i]valueForKey:@"discription"]];
            
        }
    }
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
    isFiltered = FALSE;
    for(int i=0; i<[results count] ;i++)
    {
        if( [[[results objectAtIndex:i]valueForKey:@"done"]  isEqual:  @"not"])
        {
            [filteredTitle addObject: [[results objectAtIndex:i] valueForKey:@"title"]];
            [filteredPriority addObject: [[results objectAtIndex:i] valueForKey:@"priority"]];
            [filteredDates addObject:[[results objectAtIndex:i]valueForKey:@"date"]];
            [filteredDescription addObject:[[results objectAtIndex:i]valueForKey:@"discription"]];
            
        }
    }
    [self.tableview reloadData];
    [super viewDidLoad];
    [self.seacrhBar delegate];
    // Do any additional setup after loading the view.
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        isFiltered = FALSE;
    }else
    {
        isFiltered = TRUE;
        sortedTitles = [NSMutableArray new];
        sortedPriority = [NSMutableArray new];
        sortedDates = [NSMutableArray new];
        sortedDescription = [NSMutableArray new];
        
        for(NSString *title in filteredTitle)
        {
            NSRange titleRange = [title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(titleRange.location != NSNotFound )
            {
                for(int i =0;i<[filteredTitle count];i++)
                {
                    if([filteredTitle objectAtIndex:i]==title){
                [sortedTitles addObject:title];
                        [sortedPriority addObject:[filteredPriority objectAtIndex:i]];
                        [sortedDescription addObject:[filteredDescription objectAtIndex:i]];
                        [sortedDates addObject:[filteredDates objectAtIndex:i]];
                    }
                    
                }
        }
    }
        
    }
    [self.tableview reloadData];
}
- (IBAction)addNew:(id)sender {
    AddToDoViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddToDoVC"];
    [self.navigationController pushViewController:obj animated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isFiltered == FALSE)
    {
    return filteredTitle.count ;
    }else
    {
    return sortedTitles.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20; // you can have your own choice, of course
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *title =[cell viewWithTag:1];
    UILabel *priority =[cell viewWithTag:2];
    UIImageView *status = [cell viewWithTag:3];
    if(isFiltered == FALSE){
    title.text = [filteredTitle objectAtIndex:indexPath.row];
    priority.text = [filteredPriority objectAtIndex:indexPath.row];
    status.image = [UIImage imageNamed:@"List"];
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
}else
{
    title.text = [sortedTitles objectAtIndex:indexPath.row];
    priority.text = [sortedPriority objectAtIndex:indexPath.row];
    status.image = [UIImage imageNamed:@"List"];
    if([[sortedPriority objectAtIndex:indexPath.row]  isEqual: @"Low"])
    {
        priority.backgroundColor = [UIColor greenColor];
    }else if ([[sortedPriority objectAtIndex:indexPath.row]  isEqual: @"High"])
    {
        priority.backgroundColor = [UIColor redColor];
    }else
    {
        priority.backgroundColor
        = [UIColor yellowColor];
    }

    return cell;
}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ToDoDetailsViewController *objVC = [self.storyboard instantiateViewControllerWithIdentifier:@"toDoDetailsVC"];
    if(isFiltered == FALSE)
    {
    objVC.str = [filteredTitle objectAtIndex:indexPath.row];
    objVC.titles = filteredTitle;
    objVC.priority = filteredPriority;
    objVC.dates = filteredDates;
    objVC.descs = filteredDescription;
    objVC.indexpath = indexPath.row;
    }else
    {
        objVC.str = [sortedTitles objectAtIndex:indexPath.row];
        objVC.titles = sortedTitles;
        objVC.priority = sortedPriority;
        objVC.dates = sortedDates;
        objVC.descs = sortedDescription;
        objVC.indexpath = indexPath.row;
    }
    [self.navigationController pushViewController:objVC animated:YES];
    [self.tableview reloadData];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
            context = appDelegate.persistentContainer.viewContext;
            NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are You Want To delete It ?"
                                                                                         message:@"Deleted data can not be restored"
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                //We add buttons to the alert controller by creating UIAlertActions:
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            results = [context executeFetchRequest:request error:NULL];
            for(int i =0;i<[results count];i++)
            {
                if([[[results objectAtIndex:i] valueForKey:@"title"] isEqual:[filteredTitle objectAtIndex:indexPath.row]])
                {
                    NSManagedObject* favoritsGrabbed = [results objectAtIndex:i];
                     [context deleteObject:favoritsGrabbed];
                    [appDelegate saveContext];
                     NSError *error = nil;
                     if (![context save:&error]) {
                         NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                     }
                }
                
            }
            [filteredTitle removeObjectAtIndex:indexPath.row];
            [filteredDescription removeObjectAtIndex:indexPath.row];
            [filteredDates removeObjectAtIndex:indexPath.row];
            [filteredPriority removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableview reloadData];
               
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
            //You can use a block here to handle a press on this button
                [alertController addAction:actionOk];
                [alertController addAction:cancel];
                [self presentViewController:alertController animated:YES completion:nil];
}
else if (editingStyle == UITableViewCellEditingStyleInsert) {
}
}



@end
