//
//  AddToDoViewController.h
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddToDoViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *toDoTitle;
@property (weak, nonatomic) IBOutlet UITextView *toDoDescription;
@property (weak, nonatomic) IBOutlet UIDatePicker *toDoDate;
@property (weak, nonatomic) IBOutlet UISlider *toDoPriority;
@end

NS_ASSUME_NONNULL_END
