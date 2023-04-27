//
//  EditTaskViewController.h
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "ViewController.h"
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditTaskViewController : ViewController

@property long int taskId;
@property Task* task;
@end

NS_ASSUME_NONNULL_END
