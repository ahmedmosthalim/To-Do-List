//
//  AddToDoViewController.m
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import "AddToDoViewController.h"
#import "AppDelegate.h"
#import "ToDoViewController.h"
#import "InProgressViewController.h"
#import "DoneViewController.h"
@interface AddToDoViewController ()
{
    AppDelegate *appDelegate ;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
    
}
@end

@implementation AddToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _toDoTitle.delegate = self;
    self.navigationItem.title =@"New";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveNewToDo)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // Do any additional setup after loading the view.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(_toDoTitle.text.length == 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        
    }
  return YES;
}
-(void)saveNewToDo
{
    
    NSString *str ;
    if(_toDoPriority.value >= 0 && _toDoPriority.value <2)
    {
        str = [NSString stringWithFormat:@"Low"];

    }else if (_toDoPriority.value >2 && _toDoPriority.value <= 3)
    {
        str = [NSString stringWithFormat:@"Medium"];
    }else
    {
        str = [NSString stringWithFormat:@"High"];
    }
    
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
    NSManagedObjectContext *entityObj = [NSEntityDescription insertNewObjectForEntityForName:@"Data" inManagedObjectContext:context];
    [entityObj setValue:_toDoTitle.text forKey:@"title"];
    [entityObj setValue:str forKey:@"priority"];
    [entityObj setValue:_toDoDescription.text forKey:@"discription"];
    [entityObj setValue:_toDoDate.date forKey:@"date"];
    [entityObj setValue:@"not" forKey:@"done"];
    [appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:YES];
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
