//
//  ToDoFilteredDetailsViewController.m
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 29/01/2022.
//

#import "ToDoFilteredDetailsViewController.h"

@interface ToDoFilteredDetailsViewController ()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
    NSMutableArray *results;
}
@end

@implementation ToDoFilteredDetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a  d/MM/yyyy"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *stringFromDate = [formatter stringFromDate:[_dates objectAtIndex:_indexpath]];
    
    appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
    results = [context executeFetchRequest:request error:NULL];

    _toDoPriority.text = [_priority objectAtIndex:_indexpath];
    _toDoDescrription.text =[_descs objectAtIndex:_indexpath];
    _toDoDate.text = stringFromDate;
    self.navigationItem.title =[_titles objectAtIndex:_indexpath ];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(showUiAlert)];
    UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(showUiAlert)];
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(showUiAlert)];

    self.navigationItem.rightBarButtonItems =[NSArray arrayWithObjects:editBtn, doneBtn, nil];
    }
-(void)showUiAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are You Did It ?"
                                                                                 message:@"move to done list"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self moveToDone];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
}
-(void)moveToDone
{
    appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
    results = [context executeFetchRequest:request error:NULL];
    for(int i=0;i<[results count];i++)
    {
        if([[[results objectAtIndex:i] valueForKey:@"title"] isEqual:[_titles objectAtIndex:_indexpath]])
        {
            NSManagedObject* favoritsGrabbed = [results objectAtIndex:i];
             [favoritsGrabbed setValue:@"Yes" forKey:@"done"];
            [appDelegate saveContext];
            NSLog(@"%@",[[results objectAtIndex:i]valueForKey:@"done"]);
             NSError *error = nil;
             // Save the object to persistent store
             if (![context save:&error]) {
                 NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
             }
        }
        
    }

//    NSManagedObject* favoritsGrabbed = [results objectAtIndex:_indexpath] ;
//     [favoritsGrabbed setValue:@"Yes" forKey:@"done"];
//    [appDelegate saveContext];
//    NSLog(@"%@",[[results objectAtIndex:_indexpath]valueForKey:@"done"]);
//     NSError *error = nil;
//     // Save the object to persistent store
//     if (![context save:&error]) {
//         NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//     }
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)deleteItem:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are You Want To delete It ?"
                                                                                 message:@"Deleted data can not be restored"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteItem];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    //You can use a block here to handle a press on this button
        [alertController addAction:actionOk];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
    
   
}
-(void)deleteItem
{
    appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
    results = [context executeFetchRequest:request error:NULL];
    for(int i =0;i<[results count];i++)
    {
        if([[[results objectAtIndex:i] valueForKey:@"title"] isEqual:[_titles objectAtIndex:_indexpath]])
        { NSManagedObject* favoritsGrabbed = [results objectAtIndex:i];
             [context deleteObject:favoritsGrabbed];
            [appDelegate saveContext];
             NSError *error = nil;
             // Save the object to persistent store
             if (![context save:&error]) {
                 NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
             }
    [self.navigationController popViewControllerAnimated:YES];
        }}
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
