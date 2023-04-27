//
//  DoneTasksViewController.m
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "DoneTasksViewController.h"
#import "AddingTaskViewController.h"
#import "TableViewCell.h"
#import "EditTaskViewController.h"
@interface DoneTasksViewController ()
@property (weak, nonatomic) IBOutlet UITableView *doneTable;

@end
NSUserDefaults *ddd;
NSMutableArray <Task*> * tasksArrw;
 NSArray <Task*> * tasksDONEe;
BOOL isFiltered=NO;
NSArray <Task*> * tasksDone;
NSMutableArray <Task*> * lowTasksd;
NSMutableArray <Task*> * highTasksd;
NSMutableArray <Task*> * medTasksd;
NSMutableArray <Task*> * tasksArrSplitedd;
@implementation DoneTasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   ddd =[NSUserDefaults standardUserDefaults];     
}
- (IBAction)filter:(id)sender {
    
    printf("filtering");
    isFiltered=!isFiltered;
    if(isFiltered){
     
            lowTasksd=[NSMutableArray new];
            medTasksd=[NSMutableArray new];
            highTasksd=[NSMutableArray new];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:YES];

        NSArray *sortedItems = [tasksArrw sortedArrayUsingDescriptors:@[sortDescriptor]];
            for(Task *i in sortedItems){
                if([i priority]==0){
                    [lowTasksd addObject:i];
                }else if ([i priority ]==1){
                    [medTasksd addObject:i];
                }else{
                    [highTasksd addObject:i];
                }
            }
         
            
        
      
        tasksArrw=sortedItems;
        
    }else{
        
        NSError *errr;
        
        
        NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
      
        tasksArrw=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:[ddd objectForKey:@"doneTasks"] error:&errr];
 
        printf("size of in progress ytaskkks %lu",(unsigned long)tasksArrw.count);
    
        
    }
    [self.doneTable reloadData];
}
 
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
 
  
    printf("done view will appear \n");
 
    tasksArrw=[NSMutableArray new];
    printf("\nDONE viewcontroller: view will appear \n");
    NSError *errr;
    
    NSDate *sav=[ddd objectForKey:@"doneTasks"];
    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
    tasksDONEe=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:[ddd objectForKey:@"doneTasks"] error:&errr];
 
    for(int i =0;i<tasksDONEe.count ;i++){
        [tasksArrw addObject:tasksDONEe[i]];
        printf("\n1-name %s ,type %d \n",[tasksDONEe[i].name UTF8String],tasksDONEe[i].type);
    }
 
    
    [self.doneTable reloadData];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(isFiltered){
        switch (section) {
            case 0:
              
                return @"Easy";
                break;
            case 1:
               
                return  @"Medium";
                break;
            case 2:
               
                return  @"High";
                break;
            default:
                printf("default");
                return @"";
                break;
        }
    }
    return @"";
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    printf("kkkkkk");
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"donecell" forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"celll" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(isFiltered){
        switch(indexPath.section){
            case 0:
                cell.nameLbl.text=[[lowTasksd objectAtIndex:indexPath.row] name];
              
                [cell.profileImage setImage:[UIImage imageNamed:@"low"]];
                
                break;
            case 1:
                cell.nameLbl.text=[[medTasksd objectAtIndex:indexPath.row] name];
                
          
                    [cell.profileImage setImage:[UIImage imageNamed:@"med"]];
              
                break;
                
            case 2:
                cell.nameLbl.text=[[highTasksd objectAtIndex:indexPath.row] name];
                
             
                    [cell.profileImage setImage:[UIImage imageNamed:@"high"]];
               
                break;
                
                
        }
        
        
    }else{
        cell.nameLbl.text=[[tasksArrw objectAtIndex:indexPath.row] name];
        
        if([[tasksArrw objectAtIndex:indexPath.row] priority]==2){
            [cell.profileImage setImage:[UIImage imageNamed:@"high"]];
        }else if ([[tasksDone objectAtIndex:indexPath.row] priority]==1){
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
    
    if(isFiltered){
        switch(section){
            case 0:
                return lowTasksd.count;
                break;
            case 1:
                return medTasksd.count;
                break;
            case 2:
                return highTasksd.count;
                break;
        }
    }
    return [tasksArrw count];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(isFiltered)
        return 3;
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"Delete alert" message:@"Are you sure to delete?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yes= [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSError *err;

            NSError *errr;

            NSDate *sav=[ddd objectForKey:@"doneTasks"];
            NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
              NSMutableArray <Task*> * tasksArrr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
            if(isFiltered){
                int n ;
                switch(indexPath.section){
                    case 0:
                       
                    n=[tasksDone indexOfObject:[lowTasksd objectAtIndex:indexPath.row]];
                        [tasksArrr removeObjectAtIndex:n];
                        [lowTasksd removeObjectAtIndex:indexPath.row];
                        break;
                    case 1:
                         
                        [tasksArrr removeObjectAtIndex:[tasksDone indexOfObject:[medTasksd objectAtIndex:indexPath.row]]];
                        [medTasksd removeObjectAtIndex:indexPath.row];
                        break;
                    case 2:
                        
                        [tasksArrr removeObjectAtIndex:[tasksDone indexOfObject:[highTasksd objectAtIndex:indexPath.row]]];
                        [highTasksd removeObjectAtIndex:indexPath.row];
                        break;
                }
                
            }else
            [tasksArrr removeObjectAtIndex:indexPath.row];
            
            NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArrr requiringSecureCoding:YES error:&err];

          
            [ddd setObject:da  forKey:@"doneTasks"];
            
 
            sav=[ddd objectForKey:@"doneTasks"];
         set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
            tasksArrw=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
            
            [self.doneTable reloadData];
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
    if(isFiltered){
        
        switch(indexPath.section){
            case 0:
                details.task=[lowTasksd objectAtIndex:indexPath.row];
                
                details.taskId=[tasksDone indexOfObject:[lowTasksd objectAtIndex:indexPath.row]];
                break;
            case 1:
                details.task=[medTasksd objectAtIndex:indexPath.row];
                
                    details.taskId=[tasksDone indexOfObject:[medTasksd objectAtIndex:indexPath.row]];
                break;
            case 2:
                details.task=[highTasksd objectAtIndex:indexPath.row];
                
                    details.taskId=[tasksDone indexOfObject:[highTasksd objectAtIndex:indexPath.row]];
                break;
        }
        printf("sssssssssssssss %d\n",[tasksDone indexOfObject:[highTasksd objectAtIndex:indexPath.row]]);
        
    }else{
        details.task=[tasksArrw objectAtIndex:indexPath.row];
        details.taskId=indexPath.row;
    }
    [self.navigationController pushViewController:details animated:YES];
    
}
@end
