//
//  TabBaeViewController.m
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 30/01/2022.
//

#import "TabBaeViewController.h"
#import "ToDoViewController.h"
#import "InProgressViewController.h"
#import "DoneViewController.h"
@interface TabBaeViewController ()

@end

@implementation TabBaeViewController

- (void)viewDidLoad {
    appDelegate = (AppDelegate  *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:@"Data"];
    results = [context executeFetchRequest:request error:NULL];
    self.delegate = self;
    ToDoViewController *sec = [ToDoViewController new];
    [sec.tableview reloadData];
    InProgressViewController *sec1 = [InProgressViewController new];
    [sec1.tableview reloadData];
    DoneViewController *sec2 = [DoneViewController new];
    [sec2.tableview reloadData];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
