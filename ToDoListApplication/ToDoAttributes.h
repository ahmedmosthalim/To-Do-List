//
//  ToDoAttributes.h
//  ToDoListApplication
//
//  Created by Ahmed Mostafa on 28/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoAttributes : NSObject
@property NSString *toDoTitle;
@property NSString *toDoDescription;
@property NSDate *toDoDate;
@property BOOL toDoDone;
@property int toDoPriority;

@end

NS_ASSUME_NONNULL_END
