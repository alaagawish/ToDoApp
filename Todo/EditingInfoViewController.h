//
//  EditingInfoViewController.h
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditingInfoViewController : ViewController<UIDocumentPickerDelegate>
@property Task * taskToEdit;
@property long int taskId;
@end

NS_ASSUME_NONNULL_END
