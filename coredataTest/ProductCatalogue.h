//
//  ProductCatalogue.h
//  CoreDataPOC
//
//  Created by Prem kumar on 21/03/14.
//  Copyright (c) 2014 happiestminds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ProductCatalogue : NSManagedObject

@property (nonatomic, retain) NSNumber * p_id;
@property (nonatomic, retain) NSString * p_name;

@end
