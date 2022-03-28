//
//  ToDoFilteredDetailsViewController.h
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 29/01/2022.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToDoFilteredDetailsViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *toDoDescrription;
@property (weak, nonatomic) IBOutlet UILabel *toDoDate;
@property (weak, nonatomic) IBOutlet UILabel *toDoPriority;

@property int indexpath;
@property NSString *str;
@property NSMutableArray *dates;
@property NSMutableArray *titles;
@property NSMutableArray *descs;
@property NSMutableArray *priority;
@end

NS_ASSUME_NONNULL_END
