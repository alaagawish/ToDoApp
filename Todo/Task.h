//
//  Task.h
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject<NSCoding, NSSecureCoding>
@property(readwrite) NSString *name;
@property(readwrite) NSString *desc;
@property(readwrite) int priority; //0 for easy ,1 for med ,2 for high
@property(readwrite) int type;//0 for todo ,1 for inprogress ,2 for done
@property(nullable) NSDate *date;
@property int id;

//-(Task* )getTaskById:(int)id fromArray:(NSMutableArray*)arr;
-(void) setTaskWithName:(NSString *) name andDesc:(NSString*) desc andPriority:(int)priority andType:(int)type andDate:(NSDate*)date ;

-(void) encodeWithCoder:(NSCoder *)coder;

@end

NS_ASSUME_NONNULL_END
