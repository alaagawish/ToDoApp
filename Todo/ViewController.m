//
//  ViewController.m
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "AddingTaskViewController.h"
#import "EditTaskViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableee;
@property (weak, nonatomic) IBOutlet UISearchBar *search;

@end
NSUserDefaults *d;
NSMutableArray <Task*> * tasksArr;
NSMutableArray <Task*> * filteredTasksArray;
NSArray <Task*> * tasksTODO;
BOOL isSearching=NO;

NSArray <Task*> * tasksProgress;

@implementation ViewController
static NSMutableArray *toDoTasks ;
static NSMutableArray *inProgressTasks;
static NSMutableArray *doneTasks ;
- (instancetype)init{
    self=[super init];
    if(self){
    
        toDoTasks =[NSMutableArray new];
        inProgressTasks =[NSMutableArray new];
        doneTasks =[NSMutableArray new];
        printf("donee\n");
        
    }
    
   
    return self;
}
- (void)addToDoneTasks:(Task *)t{
    [doneTasks addObject:t];
    NSError *err;
   

    NSError *errr;
 
    NSDate *sav=[d objectForKey:@"doneTasks"];
    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
      NSMutableArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];

    [tasksArr addObject:t];
    
    NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArr requiringSecureCoding:YES error:&err];

    [d setObject:da  forKey:@"doneTasks"];

  
}
- (void)addToToDoTasks:(Task *)t{
    [toDoTasks addObject:t];
    NSError *err;

    NSError *errr;
   
    NSDate *sav=[d objectForKey:@"toDoTasks"];
    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
      NSMutableArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];

    [tasksArr addObject:t];
    
    NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArr requiringSecureCoding:YES error:&err];


    [d setObject:da  forKey:@"toDoTasks"];
    

}
- (void)addToInProgressTasks:(Task *)t{
    [inProgressTasks addObject:t];
    printf("\nadding to in progress \n");
    NSError *err;
    
    NSError *errr;
  
    NSDate *sav=[[NSUserDefaults standardUserDefaults] objectForKey:@"inProgressTasks"];
    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
      NSMutableArray <Task*> * tasksArrr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];

    [tasksArrr addObject:t];
    
    NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArrr requiringSecureCoding:YES error:&err];
     [[NSUserDefaults standardUserDefaults] setObject:da  forKey:@"inProgressTasks"];
    

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    tasksArr=[NSMutableArray new];
    filteredTasksArray=[NSMutableArray new];
    printf("\nviewcontroller: view will appear \n");
    NSError *errr;
    
    NSDate *sav=[d objectForKey:@"toDoTasks"];
    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
   tasksTODO=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:[d objectForKey:@"toDoTasks"] error:&errr];
   tasksProgress=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:[d objectForKey:@"inProgressTasks"] error:&errr];
    tasksArr=tasksTODO;

    [self.tableee reloadData];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search.delegate = self;

    d =[NSUserDefaults standardUserDefaults];
 
}
 
- (IBAction)goAddTask:(id)sender {
    AddingTaskViewController *newColl=[self.storyboard instantiateViewControllerWithIdentifier:@"addTaskDetails"];

    [self.navigationController pushViewController:newColl animated:YES];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
 
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(isSearching){
        cell.nameLbl.text=[[filteredTasksArray objectAtIndex:indexPath.row] name];
        
        if([[filteredTasksArray objectAtIndex:indexPath.row] priority]==2){
            [cell.profileImage setImage:[UIImage imageNamed:@"high"]];
        }else if ([[filteredTasksArray objectAtIndex:indexPath.row] priority]==1){
            [cell.profileImage setImage:[UIImage imageNamed:@"med"]];
        }else{
            [cell.profileImage setImage:[UIImage imageNamed:@"low"]];
        }
  
    }else{
        cell.nameLbl.text=[[tasksArr objectAtIndex:indexPath.row] name];
        
        if([[tasksArr objectAtIndex:indexPath.row] priority]==2){
            [cell.profileImage setImage:[UIImage imageNamed:@"high"]];
        }else if ([[tasksArr objectAtIndex:indexPath.row] priority]==1){
            [cell.profileImage setImage:[UIImage imageNamed:@"med"]];
        }else{
            [cell.profileImage setImage:[UIImage imageNamed:@"low"]];
        }

        
    }
    cell.profileImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.profileImage.clipsToBounds = YES;
    cell.profileImage.layer.cornerRadius =  cell.profileImage.frame.size.width / 2.0f;
    cell.profileImage.layer.masksToBounds = YES;
return cell;

}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isSearching){
        return filteredTasksArray.count;
    }else
    return [tasksArr count];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"Delete alert" message:@"Are you sure to delete?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yes= [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            NSError *err;

            NSError *errr;

            NSDate *sav=[d objectForKey:@"toDoTasks"];
            NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
              NSMutableArray <Task*> * tasksArrr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
            if(isSearching){
               
                Task *task=[filteredTasksArray objectAtIndex:indexPath.row];
               //[filteredTasksArray removeObjectAtIndex:indexPath.row];
                int taskId=[tasksArr indexOfObject:[filteredTasksArray objectAtIndex:indexPath.row]];
                [tasksArrr removeObjectAtIndex:taskId];
            }else{
                [tasksArrr removeObjectAtIndex:indexPath.row];
            }
//            [tasksArrr removeObjectAtIndex:indexPath.row];
//            _search.text=@"";
            NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArrr requiringSecureCoding:YES error:&err];

          
            [d setObject:da  forKey:@"toDoTasks"];
            
 
            sav=[d objectForKey:@"toDoTasks"];
         set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
              tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
            
            [self.tableee reloadData];
            //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
          
        }];
        
        [alertCon  addAction:yes];
        
        UIAlertAction *cancel= [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
        
        [alertCon  addAction:cancel];
        [self presentViewController:alertCon animated:YES completion:NULL];
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditTaskViewController *details =[self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    
  
    if(isSearching){
       
        details.task=[filteredTasksArray objectAtIndex:indexPath.row];
    
        details.taskId=[tasksArr indexOfObject:[filteredTasksArray objectAtIndex:indexPath.row]];
      
    }else{
        details.task=[tasksArr objectAtIndex:indexPath.row];
        
        details.taskId=indexPath.row;
    }
  
 
    [self.navigationController pushViewController:details animated:YES];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
           isSearching = NO;
        [filteredTasksArray removeAllObjects];
       } else {
          isSearching = YES;
           [filteredTasksArray removeAllObjects];
           for (Task  *task in tasksArr) {
               NSRange range = [task.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
               if (range.location != NSNotFound) {
                   [filteredTasksArray addObject:task];
               }
           }
       }
       [self.tableee reloadData];
}
@end
