//
//  AddingTaskViewController.m
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "AddingTaskViewController.h"
#import "ViewController.h"
#import "Task.h"
@interface AddingTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskDescription;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@end
int levelDegree=0;
NSString *selectedDate;
@implementation AddingTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _date.minimumDate=[NSDate date];
}
- (IBAction)priorityLevel:(id)sender {
  
    switch ([sender selectedSegmentIndex]) {
            case 0:
            levelDegree=0;
        
            break;
            case 1:
            levelDegree=1;
                break;
            case 2:
            levelDegree=2;
                break;
            default:
                break;
        }
    printf("%d level degree ",levelDegree);
    

}


- (IBAction)addTask:(id)sender {
    NSLog(@"Selected date:ssss %@\n3", selectedDate);
    if( [ selectedDate compare:[NSDate date]] == NSOrderedDescending){
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"Date" message:@"Pick a future date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok= [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCon  addAction:ok];
        [self presentViewController:alertCon animated:YES completion:NULL];
    }else if(_taskName.text.length>0 && _taskDescription.text.length){
        printf("\ndone now add task\n ");
        
        Task *t1=[Task new];
 
        [t1 setDate:self.date.date];
        [t1 setTaskWithName:_taskName.text andDesc:_taskDescription.text andPriority:levelDegree andType:0 andDate:self.date.date ];
 
        printf("\ntask added in addingtaskvc\n");
 
          [[ ViewController new] addToToDoTasks:t1];
 
 
 
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"Checking information" message:@"Complete task information..." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok= [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCon  addAction:ok];
        [self presentViewController:alertCon animated:YES completion:NULL];
     
    }
    
}



@end
