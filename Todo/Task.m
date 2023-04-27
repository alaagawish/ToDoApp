//
//  Task.m
//  Todo
//
//  Created by Alaa on 26/04/2023.
//

#import "Task.h"

@implementation Task


- (void)encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeInt:_type forKey:@"type"];
    [coder encodeInt:_priority forKey:@"priority"];
    [coder encodeObject:_date forKey:@"date"];
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if(self==[super init]){
        _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _desc = [coder decodeObjectOfClass:[NSString class] forKey:@"desc"];
        _date = [coder decodeObjectOfClass:[NSDate class] forKey:@"date"];
        _type=[coder decodeIntForKey:@"type"];
        _priority=[coder decodeIntForKey:@"priority"];
        
        printf("from init");
    }
    return self;
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

- (void)setTaskWithName:(NSString *)name andDesc:(NSString *)desc andPriority:(int)priority andType:(int)type andDate:(NSDate *)date {
    _name=name;
    _date=date;
    _desc=desc;
    _type=type;
    _priority=priority;
}
 

@end
