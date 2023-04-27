//
//  EditTaskViewController.m
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "EditTaskViewController.h"
#import "EditingInfoViewController.h"
@interface EditTaskViewController ()
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UILabel *taskDescription;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDate;
@property (weak, nonatomic) IBOutlet UIImageView *taskPriority;
@property (weak, nonatomic) IBOutlet UILabel *progress;
@property (weak, nonatomic) IBOutlet UIButton *edieButton;

@end

@implementation EditTaskViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if(self.task.type==2){
        _edieButton.hidden=YES;
    }else{
        _edieButton.hidden=NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
     
    
    _taskName.text=self.task.name;
    _taskDescription.text=self.task.desc;
    if(self.task.type==0){
        _progress.text=@"TODO";
    }else if(self.task.type==1){
        _progress.text=@"Inprogress";
    }else{
        _progress.text=@"Done";
    }
    
    if(self.task.priority==2){
        [_taskPriority setImage:[UIImage imageNamed:@"high"]];
        _taskPriority.contentMode = UIViewContentModeScaleAspectFill;
        _taskPriority.clipsToBounds = YES;
        _taskPriority.layer.cornerRadius = _taskPriority.frame.size.width / 2.0f;
        _taskPriority.layer.masksToBounds = YES;
    }else if(self.task.priority==1){
        [_taskPriority setImage:[UIImage imageNamed:@"med"]];
        _taskPriority.contentMode = UIViewContentModeScaleAspectFill;
        _taskPriority.clipsToBounds = YES;
        _taskPriority.layer.cornerRadius = _taskPriority.frame.size.width / 2.0f;
        _taskPriority.layer.masksToBounds = YES;
        
    }else{
        [_taskPriority setImage:[UIImage imageNamed:@"low"]];
        _taskPriority.contentMode = UIViewContentModeScaleAspectFill;
        _taskPriority.clipsToBounds = YES;
        _taskPriority.layer.cornerRadius = _taskPriority.frame.size.width / 2.0f;
        _taskPriority.layer.masksToBounds = YES;
    }
    _taskDate.date=self.task.date;
//    [_taskDate setDate:self.task.date animated:NO];
    [_taskDate setUserInteractionEnabled:NO];
}

- (IBAction)editTask:(id)sender {
    
    EditingInfoViewController *info =[self.storyboard instantiateViewControllerWithIdentifier:@"editInfo"];
//passing the task to show details
    info.taskToEdit=self.task;
    info.taskId=self.taskId;
    [self.navigationController pushViewController:info animated:YES];
    
}


@end
