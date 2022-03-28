//
//  ToDoDetailsViewController.h
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToDoDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *toDoDate;
@property (weak, nonatomic) IBOutlet UILabel *toDoPriority;
@property (weak, nonatomic) IBOutlet UITextView *toDoDescription;
@property int indexpath;
@property NSString *str;
@property NSMutableArray *dates;
@property NSMutableArray *titles;
@property NSMutableArray *descs;
@property NSMutableArray *priority;
@end

NS_ASSUME_NONNULL_END
