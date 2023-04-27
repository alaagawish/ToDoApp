//
//  ViewController.h
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "Task.h"


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

-(void)addToToDoTasks:(Task*) t;
-(void)addToInProgressTasks:(Task*) t;
-(void)addToDoneTasks:(Task*) t;



@end

