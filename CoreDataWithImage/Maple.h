//
//  Maple.h
//  CoreDataWithImage
//
//  Created by ShivKumar G on 03/09/15.
//  Copyright (c) 2015 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Maple : NSManagedObject

@property (nonatomic, retain) NSNumber * empid;
@property (nonatomic, retain) NSString * empName;
@property (nonatomic, retain) NSString * empspeciality;
@property (nonatomic, retain) NSData * empimage;
@property (nonatomic, retain) NSString * empaddr;
@property (nonatomic, retain) NSNumber * empsalary;

@end
