//
//  TabBaeViewController.h
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 30/01/2022.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface TabBaeViewController : UITabBarController <UITableViewDelegate,UITabBarControllerDelegate>
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
    NSArray *dictionaries;
    NSMutableArray *results;
}
@end

NS_ASSUME_NONNULL_END
