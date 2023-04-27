//
//  main.m
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Task.h"
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//
//        Task *t1=[Task new];
//        Task *t2=[Task new];
//        [t1 setTaskWithName:@"name" andDesc:@"desa" andPriority:1 andType:1  andDate:[NSDate date]];
//        [t2 setTaskWithName:@"name2" andDesc:@"des22" andPriority:2 andType:1 andDate:[NSDate date] ];

//        NSMutableArray *tasks =[NSMutableArray new];
//////        [tasks addObject:t1];
//////        [tasks addObject:t2];
////
//        NSError *earr;
//        NSDate *daa=[NSKeyedArchiver archivedDataWithRootObject:tasks requiringSecureCoding:YES error:&earr];
//
////
//        [[NSUserDefaults standardUserDefaults] setObject:daa  forKey:@"toDoTasks"];
////
////
//        NSDate *saav=[[NSUserDefaults standardUserDefaults] objectForKey:@"toDoTasks"];
//        NSSet *sett=[NSSet setWithArray: @[[NSArray class],[Task class],]];
//  //      NSArray <Task*> * tasksArrrr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:sett fromData:saav error:&earr];
//         NSArray <Task*> * tasksArrrr=(NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData: saav  ];
////
//        for(int i =0;i<tasksArrrr.count ;i++){
//
//            printf("name %s ,type %d \n",[tasksArrrr[i].name UTF8String],tasksArrrr[i].type);
//        }
        printf("\n\naaaaaaaaaa");
        NSError *errr;
        NSUserDefaults *d =[NSUserDefaults standardUserDefaults];
        NSDate *sav=[d objectForKey:@"toDoTasks"];
        NSSet *set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
      //    NSArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
           NSArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData: sav  ];
    //
        for(int i =0;i<tasksArr.count ;i++){
            
            printf("name %s ,type %d \n",[tasksArr[i].name UTF8String],tasksArr[i].type);
        }
        
        printf("ppppppp");
        
       sav=[d objectForKey:@"inProgressTasks"];
         set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
        //   tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
           tasksArr=(NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData: sav  ];
    //
        for(int i =0;i<tasksArr.count ;i++){
            
            printf("name %s ,type %d \n",[tasksArr[i].name UTF8String],tasksArr[i].type);
        }
        
        
        printf("dddddddddd");
       
       sav=[d objectForKey:@"doneTasks"];
        set=[NSSet setWithArray: @[[NSArray class],[Task class],]];
      //    NSArray <Task*> * tasksArr=(NSArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:sav error:&errr];
            tasksArr=(NSArray*) [NSKeyedUnarchiver unarchiveObjectWithData: sav  ];
    //
        for(int i =0;i<tasksArr.count ;i++){
            
            printf("name %s ,type %d \n",[tasksArr[i].name UTF8String],tasksArr[i].type);
        }
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
