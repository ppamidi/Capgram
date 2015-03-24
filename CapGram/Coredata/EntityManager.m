//
//  EntityManager.m
//  dBeacon Experience
//
//  Created by Prasad Pamidi on 6/9/14.
//  Copyright (c) 2014 NTG. All rights reserved.
//

#import "EntityManager.h"
#import "DLog.h"

#define kCacheName @"dBeaconExperience_cache"

@interface EntityManager ()

@property (nonatomic,strong) NSManagedObjectModel *model;
@property (nonatomic,strong) NSManagedObjectContext *context;

@end

@implementation EntityManager
@synthesize context;
@synthesize model;


#pragma mark - Retrieve all records

+ (id)entityManager {
    static EntityManager *entityManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entityManager = [[EntityManager alloc]init];
    });
    
    return entityManager;
}

- (void)setManagedContext:(NSManagedObjectContext*)managedObjectContext {
    context = managedObjectContext;
    model = context.persistentStoreCoordinator.managedObjectModel;
}

- (NSFetchedResultsController*)fetchedResultsControllerWithFetchRequest:(NSFetchRequest*)request {
    NSFetchedResultsController* controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                 managedObjectContext:context
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:kCacheName];
    [controller performFetch:nil];
    
    return controller;
}

- (NSFetchRequest*)fetchRequestForEntityName:(NSString*)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    return fetchRequest;
}


- (id)insertNewEntityForEntityName:(NSString*)entityName {
    return [NSEntityDescription
            insertNewObjectForEntityForName:entityName
            inManagedObjectContext:context];
}


#pragma mark - Delete guest record

- (void)deleteEntity:(id)entity {
    [self.context deleteObject:entity];
    [self save];
}

- (NSFetchRequest *)fetchRequestTemplateForName:(NSString *)name {
    return [model fetchRequestTemplateForName:name];
}

- (NSFetchRequest*)fetchRequestFromTemplateWithName:(NSString*)name substitutionVariables:(NSDictionary*)variables {
    return [model fetchRequestFromTemplateWithName:name substitutionVariables:variables];
}

- (id)entityForFetchRequest:(NSFetchRequest*)request {
    return [[self entitiesForFetchRequest:request] lastObject];
}

- (NSArray*)entitiesForFetchRequest:(NSFetchRequest*)request {
    NSError* error;
    NSArray* entities = [context executeFetchRequest:request error:&error];
    if (!entities) {
        DLog(@"%s\n%@\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error.userInfo);
    }
    
    return entities;
}

- (NSInteger)countForFetchRequest:(NSFetchRequest*)request {
    NSError* error;
    NSInteger entitiesCount = [context countForFetchRequest:request error:&error];
    
    return entitiesCount;
}

- (BOOL)save
{
    BOOL saveSuccess = YES;
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.context;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
#if DEBUG
            DLog(@"Error while saving managedObjectContext %@, %@", error, [error userInfo]);
#endif
            return !saveSuccess;
        }
    }
    return saveSuccess;
}

@end
