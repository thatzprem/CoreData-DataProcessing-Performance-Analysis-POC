//
//  Customer+Create.m
//  CoreDataPOC
//
//  Created by Prem kumar on 18/03/14.
//  Copyright (c) 2014 happiestminds. All rights reserved.
//

#import "Customer+Create.h"
#import "ProductCatalogue+Create.h"

@implementation Customer (Create)

+ (Customer *)customerWithName:(NSString *)name
             inManagedObjectContext:(NSManagedObjectContext *)context{
    Customer *customer = nil;
        
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Customer"];
        request.predicate = [NSPredicate predicateWithFormat:@"c_name = %@",name];
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || [matches count] >1) {
            //handle error.
        }
        else if ([matches count]) {
            customer = [matches firstObject];
        }
        else{
            customer = [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:context];
            customer.c_name = name;
        }
    }
    return customer;
}

@end
