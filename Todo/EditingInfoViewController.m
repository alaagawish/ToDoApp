//
//  EditingInfoViewController.m
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "EditingInfoViewController.h"
#import "EditTaskViewController.h"
#import "ViewController.h"
@interface EditingInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *descLbl;
@property (weak, nonatomic) IBOutlet UITextField *nameLbl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *prioritySegm;
@property (weak, nonatomic) IBOutlet UISegmentedControl *progressSegm;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
int progress;
Task *newTask;
UIDocumentPickerViewController *documentPicker;
@implementation EditingInfoViewController
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    // Do something with the selected file URL
    
}
- (IBAction)addFile:(id)sender {
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"] inMode:UIDocumentPickerModeImport];
    documentPicker.delegate = self;
  
    [_datePicker setMinimumDate:[NSDate date]];
    _nameLbl.text=self.taskToEdit.name;
    _descLbl.text=_taskToEdit.desc;
    if(self.taskToEdit.type==0){
//        _progress.text=@"TODO";
        _progressSegm.selectedSegmentIndex=0;
        progress=0;
    }else if(self.taskToEdit.type==1){
        _progressSegm.selectedSegmentIndex=1;
        progress=1;
    }else{
        _progressSegm.selectedSegmentIndex=2;
        progress=2;
    }
    
    if(self.taskToEdit.priority==2){
         _prioritySegm.selectedSegmentIndex=2;
             }else if(self.taskToEdit.priority==1){
         _prioritySegm.selectedSegmentIndex=1;
           }else{
         _prioritySegm.selectedSegmentIndex=0;
           }
    _datePicker.date=self.taskToEdit.date;
}


- (IBAction)saveEditing:(id)sender {
    newTask=[Task new];
    if(_nameLbl.text.length>0&& _descLbl.text.length>0){
        if(progress<=_progressSegm.selectedSegmentIndex){
            
            [newTask setTaskWithName:_nameLbl.text andDesc:_descLbl.text andPriority:_prioritySegm.selectedSegmentIndex andType:_progressSegm.selectedSegmentIndex andDate:_datePicker.date];
            UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure to change data?" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok= [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSUInteger indexOfObject;
                if(progress==0){
                    //todo
                    NSError *err;
                    NSError *errr;
                   
                    NSDate *sav=[[NSUserDefaults standardUserDefaults] objectForKey:@"toDoTasks"];
                    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
                      NSMutableArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
 
                    
                    if(self->_progressSegm.selectedSegmentIndex==0){
                        printf("_progressSegm.selectedSegmentIndex==0\n");
                        
                        printf("ggggggggggggggggggg\n %ld",self.taskId);
                        [tasksArr replaceObjectAtIndex:self.taskId withObject:newTask];
                    }else if (self->_progressSegm.selectedSegmentIndex==1){
                        printf("_progressSegm.selectedSegmentIndex==1\n");
                  
                        [tasksArr removeObjectAtIndex:self.taskId];
                        NSError *err;
                        
                        NSError *errr;
                      
                        NSDate *sav=[[NSUserDefaults standardUserDefaults] objectForKey:@"inProgressTasks"];
                        NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
                        NSMutableArray <Task*> * tasksArrr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
                    //        NSArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData: sav  ];
                    //
                        printf("\nsize of array=%d\n",tasksArrr.count);
                        [tasksArrr addObject:newTask];
                        
                        NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArrr requiringSecureCoding:YES error:&err];
                         [[NSUserDefaults standardUserDefaults] setObject:da  forKey:@"inProgressTasks"];
                        
                        for(int i =0;i<tasksArrr.count ;i++){
                            
                            printf("\n inProgressTasks adding: name %s ,type %d \n",[tasksArrr[i].name UTF8String],tasksArrr[i].type);
                        }
                      //  [[ViewController new] addToInProgressTasks:newTask];
                    }else if (self->_progressSegm.selectedSegmentIndex==2){
                        printf("_progressSegm.selectedSegmentIndex==2\n");
                        [tasksArr removeObjectAtIndex:self.taskId];
                        [[ViewController new]addToDoneTasks:newTask];
                    }
                    
               
                    NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArr requiringSecureCoding:YES error:&err];
 
                    [[NSUserDefaults standardUserDefaults] setObject:da  forKey:@"toDoTasks"];
                    
                    printf("done editing todo task\n");
                
                }else if (progress==1){
                    
                    //progress
                    NSError *err;
                    NSError *errr;
                   
                    NSDate *sav=[[NSUserDefaults standardUserDefaults] objectForKey:@"inProgressTasks"];
                    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
                      NSMutableArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
//                        indexOfObject=[tasksArr indexOfObject:self.taskToEdit];
//
//
                    if (self->_progressSegm.selectedSegmentIndex==1){

                       
                        [tasksArr replaceObjectAtIndex:self.taskId withObject:newTask];
                    }else if (self->_progressSegm.selectedSegmentIndex==2){
                        printf("_progressSegm.selectedSegmentIndex==1\n");
//                  
//                        [tasksArr removeObjectAtIndex:self.taskId];
//                        NSError *err;
//                        
//                        NSError *errr;
//                      
//                        NSDate *sav=[[NSUserDefaults standardUserDefaults] objectForKey:@"doneTasks"];
//                        NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
//                        NSMutableArray <Task*> * tasksArrr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
                    //        NSArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData: sav  ];
                    //
//                        printf("\nsize of array=%d\n",tasksArrr.count);
//                        [tasksArrr addObject:newTask];
//
//                        NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArrr requiringSecureCoding:YES error:&err];
//                         [[NSUserDefaults standardUserDefaults] setObject:da  forKey:@"doneTasks"];
//
//                        for(int i =0;i<tasksArrr.count ;i++){
//
//                            printf("\n inProgressTasks adding: name %s ,type %d \n",[tasksArrr[i].name UTF8String],tasksArrr[i].type);
//                        }
//                      //  [[ViewController new] addToInProgressTasks:newTask];
//
                        printf("_progressSegm.selectedSegmentIndex==2\n");
                        [tasksArr removeObjectAtIndex:self.taskId];
                        [[ViewController new]addToDoneTasks:newTask];
                    }
                    
               
                    NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArr requiringSecureCoding:YES error:&err];
 
                    [[NSUserDefaults standardUserDefaults] setObject:da  forKey:@"toDoTasks"];
                    
                    printf("done editing todo task\n");
                    printf("done editing inprogress task\n");
                    
                }
//                else{
//
//
//                        //done
//                    NSError *err;
//                    NSError *errr;
//
//                    NSDate *sav=[[NSUserDefaults standardUserDefaults] objectForKey:@"doneTasks"];
//                    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
//                      NSMutableArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
////                        indexOfObject=[tasksArr indexOfObject:self.taskToEdit];
//                    if (self->_progressSegm.selectedSegmentIndex==2){
//
//                        [tasksArr replaceObjectAtIndex:self.taskId withObject:newTask];
//
//                    }
//                    NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArr requiringSecureCoding:YES error:&err];
//
//                  // NSUserDefaults *d =[NSUserDefaults standardUserDefaults];
//                    [[NSUserDefaults standardUserDefaults] setObject:da  forKey:@"doneTasks"];
//                    printf("done editing done task\n");
//
//                }
                
                [self.navigationController popViewControllerAnimated:YES];
                [self.navigationController popViewControllerAnimated:NO];
                
                
                EditTaskViewController *info =[self.storyboard instantiateViewControllerWithIdentifier:@"details"];
            //passing the task to show details
                info.task=newTask;
                
                [self.navigationController pushViewController:info animated:YES];
                
                
            }];
            
            [alertCon  addAction:ok];
            
            UIAlertAction *no= [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
            
            [alertCon  addAction:no];
            [self presentViewController:alertCon animated:YES completion:NULL];
        }else{
            UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"Error Editing" message:@"You can't return status back." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok= [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
            
            [alertCon  addAction:ok];
            [self presentViewController:alertCon animated:YES completion:NULL];
         
        }
    
    }else{
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"Checking information" message:@"Complete task information..." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok= [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCon  addAction:ok];
        [self presentViewController:alertCon animated:YES completion:NULL];
     
    }
}

@end
