//
//  ToDoViewController.h
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import <UIKit/UIKit.h>
#import "ToDoAttributes.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoViewController : UIViewController  <UITableViewDelegate ,UITableViewDataSource,UISearchBarDelegate,UITabBarControllerDelegate,UITabBarDelegate >
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UISearchBar *seacrhBar;

@end

NS_ASSUME_NONNULL_END
