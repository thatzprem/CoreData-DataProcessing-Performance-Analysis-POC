//
//  ProductCatalogue+Create.h
//  CoreDataPOC
//
//  Created by Prem kumar on 18/03/14.
//  Copyright (c) 2014 happiestminds. All rights reserved.
//

#import "ProductCatalogue.h"

@interface ProductCatalogue (Create)

+ (ProductCatalogue *)productWithName:(NSString *)name
               inManagedObjectContext:(NSManagedObjectContext *)context;

@end
