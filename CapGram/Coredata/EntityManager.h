//
//  EntityManager.h
//  dBeacon Experience
//
//  Created by Prasad Pamidi on 6/9/14.
//  Copyright (c) 2014 NTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface EntityManager : NSObject
+ (id)entityManager;
- (id)entityForFetchRequest:(NSFetchRequest*)request;
- (id)insertNewEntityForEntityName:(NSString*)entityName;
- (void)deleteEntity:(id)entity;
- (void)setManagedContext:(NSManagedObjectContext*)managedObjectContext;
- (BOOL)save;
- (NSFetchedResultsController*)fetchedResultsControllerWithFetchRequest:(NSFetchRequest*)request;
- (NSFetchRequest *)fetchRequestTemplateForName:(NSString *)name;
- (NSArray*)entitiesForFetchRequest:(NSFetchRequest*)request;
- (NSInteger)countForFetchRequest:(NSFetchRequest*)request;
- (NSFetchRequest*)fetchRequestFromTemplateWithName:(NSString*)name substitutionVariables:(NSDictionary*)variables;
@end
