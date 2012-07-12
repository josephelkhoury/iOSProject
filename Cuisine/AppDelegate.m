//
//  AppDelegate.m
//  Cuisine
//
//  Created by SEKIMIA on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize dataController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) 
    {
        // Handle the error.
    }
    NSError *error = nil;
    /*
    Recette *recette;
     
    recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:self.managedObjectContext];
     
     recette.name = @"Tourte sans pâte aux champignons";
     recette.category = @"Entrée";
     recette.ingredients = @"2 oeufs,100 g de champignons,100 g de farine,50 g de fromage râpé,sel et poivre";
     recette.preparation = @"Préchauffer le four à thermostat 6 (180°C). Casser les oeufs dans un saladier. Les mettre dans un grand plat, ajouter la farine, bien mélanger. Saler et poivrer. Ajouter les champignons, surtout ne pas mélanger. Mettre au four 1/4 d'heure. Sortir du four, ajouter le fromage râpé sur le dessus. Remettre au four encore un quart d'heure. Manger la tourte tout de suite aprés l'avoir sortie.";
     recette.difficulty = @"Cuisinier occasionnel";
     recette.time = @"75";
     recette.origin = @"France";
     recette.picture = @"quiche.jpeg";
     recette.rating = [NSNumber numberWithDouble:2.5];
     
     //[self.dataController addRecette:recette];
     
     recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:self.managedObjectContext];
     
     recette.name = @"Bananes au four, abricots secs et noisettes";
     recette.category = @"Dessert";
     recette.ingredients = @"1 banane mûre,1 petit-suisses à 40%,2 abricots secs,1 cuillère café de noisettes concassées (ou amandes) grillées,1 cuillère à café de céréales souflées (riz, mélange...),1 petite cuillère à café de miel";
     recette.preparation = @"Préchauffer votre four 5 minutes à 180°C. Placer les bananes entières sur une grille pour 25 minutes environ. Laisser tiédir pour pouvoir les peler sans vous brûler. Mélanger le petit-suisse et le miel. Disposer ce mélange dans une assiette. Placer la banane pelée dessus et rajouter sur le dessus les abricots secs coupés en petits morceaux ainsi que les cérales soufflées et les noisettes grillées. Idéal pour un dessert ou un goûter équilibré pour enfants et parents accompagnateurs !.";
     recette.difficulty = @"Étudiant";
     recette.time = @"30";
     recette.origin = @"Italie";
     recette.picture = @"bananes.jpeg";
     recette.rating = [NSNumber numberWithDouble:2.3];
     
     //[self.dataController addRecette:recette];
     
     recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:self.managedObjectContext];
     
     recette.name = @"Charlotte aux langues de chat";
     recette.category = @"Dessert";
     recette.ingredients = @"100 g de chocolat,60 langues de chat,40 g de sucre en poudre,4 œufs,Un peu de chocolat râpé,De la crème chantilly";
     recette.preparation = @"La mousse de chocolat : Faire fondre le chocolat au bain-marie. Casser le œufs en séparant les blancs des jaunes. Fouetter les jaunes avec le sucre et ajouter le chocolat fondu. Battre les blancs en neige avec un peu de sel et les incorporer à la mousse de chocolat. Mettre 1 heure au réfrigérateur. Couvrir de film le fond des parois d'un moule à charlotte. Tapisser le moule de langues, face bombée vers l'extérieur. Verser le mélange et le recouvrir de langues de chat. Réserver 3 heures au réfrigérateur. Retourner la charlotte sur un plat. Enlever le film alimentaire et décorer de crème chantilly et de chocolat râpé. Servir aussitôt assez frais.";
     recette.difficulty = @"Étudiant";
     recette.time = @"30";
     recette.origin = @"Canada";
     recette.picture = @"charlotte.jpeg";
     recette.rating = [NSNumber numberWithDouble:2.0];
     
     //[self.dataController addRecette:recette];
     
     recette = (Recette *)[NSEntityDescription insertNewObjectForEntityForName:@"Recette" inManagedObjectContext:self.managedObjectContext];
     
     recette.name = @"Salade normande";
     recette.category = @"Plat";
     recette.ingredients = @"100 g de chocolat,60 langues de chat,40 g de sucre en poudre,4 œufs,Un peu de chocolat râpé,De la crème chantilly";
     recette.preparation = @"250 g d'escalopes de poulet,1 poivron vert ou jaune,1 tomate,1 pomme (type canada),1 salade,1/2 Neufchâtel,éventuellement du pain,sel et poivre,huile d'olive";
     recette.difficulty = @"Gastronome";
     recette.time = @"25";
     recette.origin = @"France";
     recette.picture = @"salade.jpeg";
     recette.rating = [NSNumber numberWithDouble:5];
     
     //[self.dataController addRecette:recette];
     
     if (![self.managedObjectContext save:&error])
     {
     // Handle the error.
     }*/

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Recette" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSMutableArray *mutableFetchResults = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) 
    {
        // Handle the error.
    }
    self.dataController = [[RecetteDataController alloc] init];
    [self.dataController setMasterRecetteList:mutableFetchResults];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;

    AccueilViewController *accueilViewController = (AccueilViewController *)[[[[tabBarController viewControllers] objectAtIndex:0] viewControllers] objectAtIndex:0];
    
    RecettesViewController *recettesViewController = (RecettesViewController *)[[[[tabBarController viewControllers] objectAtIndex:1] viewControllers] objectAtIndex:0];
    
    RechercheViewController *rechercheViewController = (RechercheViewController *)[[[[tabBarController viewControllers] objectAtIndex:2] viewControllers] objectAtIndex:0];
    
    Top10ViewController *top10ViewController = (Top10ViewController *)[[[[tabBarController viewControllers] objectAtIndex:3] viewControllers] objectAtIndex:0];
    
    FavorisViewController *favorisViewController = (FavorisViewController *)[[[[tabBarController viewControllers] objectAtIndex:4] viewControllers] objectAtIndex:0];

    RecetteDataController *aDataController = self.dataController;
    accueilViewController.dataController = aDataController;
    //accueilViewController.managedObjectContext = context;
    recettesViewController.dataController = aDataController;
    recettesViewController.managedObjectContext = context;
    favorisViewController.dataController = aDataController;
    favorisViewController.managedObjectContext = context;
    rechercheViewController.dataController = aDataController;
    //rechercheViewController.managedObjectContext = context;
    top10ViewController.dataController = aDataController;
    //top10ViewController.managedObjectContext = context;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ModeleNouveau.momd"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
