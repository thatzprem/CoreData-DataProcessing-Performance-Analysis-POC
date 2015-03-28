//
//  AppDelegate.m
//  coredataTest
//
//  Created by Prem kumar on 18/03/14.
//  Copyright (c) 2014 happiestminds. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+CoreData.h"
#import "Customer+Create.h"
#import "CustomerDatabaseAvailabilty.h"
#import "ProductCatalogue+Create.h"

@interface AppDelegate()

@property (nonatomic,strong)NSManagedObjectContext *globalDatabaseContext;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.globalDatabaseContext = [self createMainQueueManagedObjectContext];
    
    [self createDBEntry];
    return YES;
}

-(void)createDBEntry{
    
    NSArray *customerNames = @[@"Jack",@"Kate",@"Sawyer",@"Hurley",@"Sun",@"Jim",@"Clare"];
    [self createCustomerDetails:customerNames];
    NSArray *productNames = @[@"Helmet",@"Google set",@"Training Aids",@"Snowboard accessories",@"Snow kites",@"Chariot carriers",@"Snow shoes"];
    [self createProductDetails:productNames];
    NSDictionary *userInfo = self.globalDatabaseContext? @{CustomerDataBaseAvailabilityContext: self.globalDatabaseContext} :nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:CustomerDatabaseAvailabilityNotification object:self userInfo:userInfo];
}

-(void)createCustomerDetails:(NSArray *)customerNames{
    NSLog(@"Customer name set: %@",customerNames);
    for (NSString *name in customerNames) {
        [Customer customerWithName:name inManagedObjectContext:self.globalDatabaseContext];
    }
}

-(void)createProductDetails:(NSArray *)ProductNames{
    NSLog(@"Product names set: %@",ProductNames);
    for (NSString *name in ProductNames) {
        [ProductCatalogue productWithName:name inManagedObjectContext:self.globalDatabaseContext];
    }
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Fetch Initated...");
    NSURL *url = [self generateFetchURL];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    sessionConfig.allowsCellularAccess = NO;
    sessionConfig.timeoutIntervalForRequest = 10.0;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                    completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
                                                        if (error)
                                                        {
                                                            NSLog(@"Background fetch failed: %@", error.localizedDescription);
                                                            completionHandler(UIBackgroundFetchResultNoData);
                                                        } else
                                                        {
                                                            NSLog(@"Background fetch successful...");
                                                            NSDictionary *flickrPropertyList;
                                                            NSData *flickrJSONData = [NSData dataWithContentsOfURL:localFile];
                                                            if (flickrJSONData) {
                                                                flickrPropertyList = [NSJSONSerialization JSONObjectWithData:flickrJSONData options:0 error:NULL];
                                                            }
                                                            [self createCustomerDetails:[flickrPropertyList allValues]];
                                                            completionHandler(UIBackgroundFetchResultNewData);
                                                        }
                                                    }];
    [task resume];
}

- (int)getRandomNumber{
    return arc4random() % 100;
}

//Method to generate a random fetch URL.
- (NSURL *)generateFetchURL{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://echo.jsontest.com/name1/testName%d/name2/testName%d/name3/testName%d/name4/testName%d",[self getRandomNumber],[self getRandomNumber],[self getRandomNumber],[self getRandomNumber]]];
}

@end
