//
//  InProgressTasksViewController.m
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "InProgressTasksViewController.h"
#import "AddingTaskViewController.h"
#import "EditTaskViewController.h"
#import "TableViewCell.h"
@interface InProgressTasksViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tablee;

@end
NSUserDefaults *dd;
BOOL isSplitted=NO;
NSArray <Task*> * tasksProgres;
NSMutableArray <Task*> * lowTasks;
NSMutableArray <Task*> * highTasks;
NSMutableArray <Task*> * medTasks;
NSMutableArray <Task*> * tasksArrSplited;

@implementation InProgressTasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dd =[NSUserDefaults standardUserDefaults];   
 
}
- (IBAction)filter:(id)sender {
    printf("filtering");
    isSplitted=!isSplitted;
    if(isSplitted){
        lowTasks=[NSMutableArray new];
        medTasks=[NSMutableArray new];
        highTasks=[NSMutableArray new];
   
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:YES];

        NSArray *sortedItems = [tasksProgres sortedArrayUsingDescriptors:@[sortDescriptor]];
        for(Task *i in sortedItems){
            if([i priority]==0){
                [lowTasks addObject:i];
            }else if ([i priority ]==1){
                [medTasks addObject:i];
            }else{
                [highTasks addObject:i];
            }
        }
        tasksProgres=sortedItems;
        
    }else{
        
        NSError *errr;
        
        NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
      
       tasksProgres=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:[dd objectForKey:@"inProgressTasks"] error:&errr];
 
       
    
        
    }
    [self.tablee reloadData];
}
 
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
  
    NSError *errr;
    
    
    NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
  
   tasksProgres=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:[dd objectForKey:@"inProgressTasks"] error:&errr];
 
  
    [self.tablee reloadData];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(isSplitted){
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
     TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"celll" forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"celll" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    
    if(isSplitted){
        switch(indexPath.section){
            case 0:
                cell.nameLbl.text=[[lowTasks objectAtIndex:indexPath.row] name];
              
                [cell.profileImage setImage:[UIImage imageNamed:@"low"]];
                
                break;
            case 1:
                cell.nameLbl.text=[[medTasks objectAtIndex:indexPath.row] name];
                
          
                    [cell.profileImage setImage:[UIImage imageNamed:@"med"]];
              
                break;
                
            case 2:
                cell.nameLbl.text=[[highTasks objectAtIndex:indexPath.row] name];
                
             
                    [cell.profileImage setImage:[UIImage imageNamed:@"high"]];
               
                break;
                
                
        }
        
        
    }else{
        cell.nameLbl.text=[[tasksProgres objectAtIndex:indexPath.row] name];
        
        if([[tasksProgres objectAtIndex:indexPath.row] priority]==2){
            [cell.profileImage setImage:[UIImage imageNamed:@"high"]];
        }else if ([[tasksProgres objectAtIndex:indexPath.row] priority]==1){
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
    if(isSplitted){
        switch(section){
            case 0:
                return lowTasks.count;
                break;
            case 1:
                return medTasks.count;
                break;
            case 2:
                return highTasks.count;
                break;
        }
    }
  
    return [tasksProgres count];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(isSplitted)
        return 3;
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertCon=[UIAlertController alertControllerWithTitle:@"Delete alert" message:@"Are you sure to delete?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yes= [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSError *err;


            NSDate *sav=[dd objectForKey:@"inProgressTasks"];
            NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
            NSMutableArray <Task*> * tasksArrr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&err];
      
            if(isSplitted){
                int n ;
                switch(indexPath.section){
                    case 0:
                       
                    n=[tasksProgres indexOfObject:[lowTasks objectAtIndex:indexPath.row]];
                        [tasksArrr removeObjectAtIndex:n];
                        [lowTasks removeObjectAtIndex:indexPath.row];
                        break;
                    case 1:
                         
                        [tasksArrr removeObjectAtIndex:[tasksProgres indexOfObject:[medTasks objectAtIndex:indexPath.row]]];
                        [medTasks removeObjectAtIndex:indexPath.row];
                        break;
                    case 2:
                        
                        [tasksArrr removeObjectAtIndex:[tasksProgres indexOfObject:[highTasks objectAtIndex:indexPath.row]]];
                        [highTasks removeObjectAtIndex:indexPath.row];
                        break;
                }
                
            }else{
                
                
                [tasksArrr removeObjectAtIndex:indexPath.row];
            }
         
           
            
            NSDate *da=[NSKeyedArchiver archivedDataWithRootObject:tasksArrr requiringSecureCoding:YES error:&err];

          
            [dd setObject:da  forKey:@"inProgressTasks"];
            
 
            sav=[dd objectForKey:@"inProgressTasks"];
         set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
            tasksProgres=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&err];
            
            [self.tablee reloadData];
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
 
    if(isSplitted){
        
        
        switch(indexPath.section){
            case 0:
                details.task=[lowTasks objectAtIndex:indexPath.row];
                
                details.taskId=[tasksProgres indexOfObject:[lowTasks objectAtIndex:indexPath.row]];
                break;
            case 1:
                details.task=[medTasks objectAtIndex:indexPath.row];
                
                    details.taskId=[tasksProgres indexOfObject:[medTasks objectAtIndex:indexPath.row]];
                break;
            case 2:
                details.task=[highTasks objectAtIndex:indexPath.row];
                
                    details.taskId=[tasksProgres indexOfObject:[highTasks objectAtIndex:indexPath.row]];
                break;
        }
        printf("sssssssssssssss %d\n",[tasksProgres indexOfObject:[highTasks objectAtIndex:indexPath.row]]);
        
        
        
    }else{
        
        details.task=[tasksProgres objectAtIndex:indexPath.row];
        details.taskId=indexPath.row;
    }
    [self.navigationController pushViewController:details animated:YES];
    
}
@end
