//
//  ToDoFilteredDoneDetailsViewController.m
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 29/01/2022.
//

#import "ToDoFilteredDoneDetailsViewController.h"
#import "AppDelegate.h"
@interface ToDoFilteredDoneDetailsViewController ()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
    NSMutableArray *results;
}

@end

@implementation ToDoFilteredDoneDetailsViewController

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
    _toDoDescription.text =[_descs objectAtIndex:_indexpath];
    _toDoDate.text = stringFromDate;
    self.navigationItem.title =[_titles objectAtIndex:_indexpath ];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"In Progress" style:UIBarButtonItemStylePlain target:self action:@selector(moveToInProgress)];

}
//-(void)moveToInProgress
//{
//    appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
//    context = appDelegate.persistentContainer.viewContext;
//    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
//    results = [context executeFetchRequest:request error:NULL];
//    for(int i=0;i<[results count];i++)
//    {
//        if([[[results objectAtIndex:i] valueForKey:@"title"] isEqual:[_titles objectAtIndex:_indexpath]])
//        {
//            NSManagedObject* favoritsGrabbed = [results objectAtIndex:i];
//             [favoritsGrabbed setValue:@"NO" forKey:@"done"];
//            [appDelegate saveContext];
//            NSLog(@"%@",[[results objectAtIndex:i]valueForKey:@"done"]);
//             NSError *error = nil;
//             // Save the object to persistent store
//             if (![context save:&error]) {
//                 NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//             }
//        }
//    }
//    [self.navigationController popViewControllerAnimated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
