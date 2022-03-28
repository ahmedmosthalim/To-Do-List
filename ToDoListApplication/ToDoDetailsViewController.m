//
//  ToDoDetailsViewController.m
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import "ToDoDetailsViewController.h"

@interface ToDoDetailsViewController ()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
    NSMutableArray *results;
}
@end

@implementation ToDoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a  d/MM/yyyy"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
    results = [context executeFetchRequest:request error:NULL];
    NSString *stringFromDate = [formatter stringFromDate:[[results objectAtIndex:_indexpath]valueForKey:@"date"]];
    _toDoPriority.text = [_priority objectAtIndex:_indexpath];
    _toDoDescription.text =[_descs objectAtIndex:_indexpath];
    _toDoDate.text = stringFromDate;
    self.navigationItem.title =[_titles objectAtIndex:_indexpath ];
    UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(showUiAlert)];
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(showUiAlert)];

    self.navigationItem.rightBarButtonItems =[NSArray arrayWithObjects:editBtn, doneBtn, nil];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"In Progress" style:UIBarButtonItemStylePlain target:self action:@selector(showUiAlert)];
}
-(void)showUiAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are You Will Start ?"
                                                                                 message:@"move to In Progress list"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"In Progress" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
             [favoritsGrabbed setValue:@"NO" forKey:@"done"];
            [appDelegate saveContext];
            NSLog(@"%@",[[results objectAtIndex:i]valueForKey:@"done"]);
             NSError *error = nil;
             // Save the object to persistent store
             if (![context save:&error]) {
                 NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
             }
        }
    [self.navigationController popViewControllerAnimated:YES];
}
}
- (IBAction)deleteAction:(id)sender {
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
