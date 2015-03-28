//
//  ProductsCDTVC.m
//  CoreDataPOC
//
//  Created by Prem kumar on 21/03/14.
//  Copyright (c) 2014 happiestminds. All rights reserved.
//

#import "ProductsCDTVC.h"
#import "Customer.h"
#import "ProductCatalogue.h"
#import "CustomerDatabaseAvailabilty.h"

@interface ProductsCDTVC ()

@end

@implementation ProductsCDTVC


- (void)awakeFromNib{
    
    [[NSNotificationCenter defaultCenter] addObserverForName:CustomerDatabaseAvailabilityNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.managedObjectContext = note.userInfo[CustomerDataBaseAvailabilityContext];
    }];
}

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ProductCatalogue"];
    request.predicate = nil;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"p_name" ascending:YES selector:@selector(localizedStandardCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ProductCatalogue Cell"];
    
    ProductCatalogue *products = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = products.p_name;
    return cell;
}


@end
