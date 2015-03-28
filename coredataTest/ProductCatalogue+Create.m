//
//  ProductCatalogue+Create.m
//  CoreDataPOC
//
//  Created by Prem kumar on 18/03/14.
//  Copyright (c) 2014 happiestminds. All rights reserved.
//

#import "ProductCatalogue+Create.h"

#define EntityName @"ProductCatalogue"

@implementation ProductCatalogue (Create)

+ (ProductCatalogue *)productWithName:(NSString *)name
        inManagedObjectContext:(NSManagedObjectContext *)context{
    ProductCatalogue *productCatalogue = nil;
    
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:EntityName];
        request.predicate = [NSPredicate predicateWithFormat:@"p_name = %@",name];

        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || [matches count] >1) {
            //handle error.
        }
        else if ([matches count]) {
            productCatalogue = [matches firstObject];
        }
        else{
            productCatalogue = [NSEntityDescription insertNewObjectForEntityForName:EntityName inManagedObjectContext:context];
            productCatalogue.p_name = name;
        }
    }
    return productCatalogue;
}

@end
