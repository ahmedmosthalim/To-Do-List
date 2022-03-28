//
//  DoneViewController.h
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import <UIKit/UIKit.h>
#import "ToDoViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

NS_ASSUME_NONNULL_END
