//
//  ToDoFilteredDoneDetailsViewController.h
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 29/01/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoFilteredDoneDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *toDoDescription;
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
