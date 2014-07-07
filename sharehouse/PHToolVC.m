//
//  PHToolVC.m
//  MovingHouse
//
//  Created by Nick Lee on 4/1/13.
//  Copyright (c) 2013 tienlp. All rights reserved.
//

#import "PHToolVC.h"
#import "Define.h"
#import "Common.h"
#import "TaskItem.h"
#import "AppDelegate.h"

#import "PHToolCell.h"

#import "PHTaskDetailVC.h"
#import "PHNewTaskVC.h"

#import "CDAlert.h"

@interface PHToolVC ()<UITableViewDataSource,UITableViewDelegate,PHTaskDetailVCDelegate,PHNewTaskVCDelegate,NSFetchedResultsControllerDelegate>
{
    IBOutlet PHToolCell *_toolCell;
    IBOutlet UITableView *_table;
    
    BOOL _isLoadCoreData;
}

@property(nonatomic,strong) NSFetchedResultsController *alretResults;

- (IBAction)checkTask:(id)sender;
- (void)returnViewController;
- (void)creatAlert;
@end

@implementation PHToolVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = TEXT_TOOL_NAVI_TITLE;
    [UITableViewCell appearance].separatorInset = UIEdgeInsetsZero;
    
    // add bar button item
    self.navigationItem.backBarButtonItem = nil;
    
    //UIButton *btAdd =  [UIButton buttonWithType:UIButtonTypeCustom];
    //[btAdd setTitle:@"追加" forState:UIControlStateNormal];
    [_btAdd addTarget:self action:@selector(addAlert) forControlEvents:UIControlEventTouchUpInside];
    //[btAdd setFrame:CGRectMake(0, 0, 51, 30)];
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btAdd];

    /*
    UIButton *btAdd =  [UIButton buttonWithType:UIButtonTypeCustom];
     
    [btAdd setImage:[UIImage imageNamed:@"btnPlus.png"] forState:UIControlStateNormal];
    [btAdd addTarget:self action:@selector(addAlert) forControlEvents:UIControlEventTouchUpInside];
    [btAdd setFrame:CGRectMake(0, 0, 30, 30)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btAdd];
    */
    
    // 戻るボタン
    /*
    UIButton *btReturn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btReturn setTitle:@"戻る" forState:UIControlStateNormal];
    [btReturn addTarget:self action:@selector(returnViewController) forControlEvents:UIControlEventTouchUpInside];
    [btReturn setFrame:CGRectMake(0, 0, 51, 30)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btReturn];
     */
    /*
    UIButton *btReturn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btReturn setImage:[UIImage imageNamed:@"btnBack.png"] forState:UIControlStateNormal];
    [btReturn addTarget:self action:@selector(returnViewController) forControlEvents:UIControlEventTouchUpInside];
    [btReturn setFrame:CGRectMake(0, 0, 51, 30)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btReturn];
    */
    // init core data
    _isLoadCoreData = YES;

    [self alretResults];
      
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Others

- (void)returnViewController
{
    //[[AppDelegate sharedAppDelegate] selectHomeTab];
}

- (void)addAlert
{
    if ([_alretResults.fetchedObjects count] < 51) {
        PHNewTaskVC *newTaskVC = [[PHNewTaskVC alloc] initWithNibName:@"PHNewTaskVC" bundle:nil];
        newTaskVC.delegate = self;
        [self.navigationController pushViewController:newTaskVC animated:YES];
    }
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_alretResults.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PHToolCell *cellR = [tableView dequeueReusableCellWithIdentifier:@"PHToolCell"];
    if (cellR == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PHToolCell" owner:self options:nil];
        cellR = _toolCell;
        _toolCell = nil;
        
    }
    
    CDAlert *item               = [_alretResults.fetchedObjects objectAtIndex:indexPath.row];
    cellR.lbTaskName.text       = item.name;
    cellR.lbTaskName.hidden     = YES;
    cellR.strLBTaksName.text    = item.name;
    cellR.btCheck.tag           = indexPath.row;
    cellR.btCheckMask.tag       = indexPath.row;
    
    if (item.isCheck) {
        [cellR.btCheck setImage:[UIImage imageNamed:@"10-checked.png"] forState:UIControlStateNormal];
        cellR.strLBTaksName.strikeThroughEnabled = YES;
    } else {
        [cellR.btCheck setImage:[UIImage imageNamed:@"10-uncheck.png"] forState:UIControlStateNormal];
        cellR.strLBTaksName.strikeThroughEnabled = NO;
    }
    
    return cellR;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CDAlert *item = [_alretResults.fetchedObjects objectAtIndex:indexPath.row];
    
    PHTaskDetailVC *taskDetailVC = [[PHTaskDetailVC alloc] initWithNibName:@"PHTaskDetailVC" bundle:nil];
    taskDetailVC.delegate = self;
    taskDetailVC.indexTask = indexPath.row;
    taskDetailVC.cdAlert = item;
    [self.navigationController pushViewController:taskDetailVC animated:YES];
    
    [taskDetailVC loadTaskInfoWithCdAlertItem:item index:indexPath.row];
}


#pragma mark - HTaskDetailVCDelegate

- (void)didChangeCheckTaskWithIndex:(long)index isCheck:(BOOL)isCheck
{
//    TaskItem *item = [_tasks objectAtIndex:index];
//    item.isCheck = isCheck;
//    [_table reloadData];
}

- (void)didDeleteTaskWithIndex:(long)index
{
    CDAlert *item = [_alretResults.fetchedObjects objectAtIndex:index];
    [[AppDelegate sharedAppDelegate].managedObjectContext deleteObject:item];
    [[AppDelegate sharedAppDelegate] saveContext];
}

#pragma mark - PHNewTaskVCDelegate
- (void)didFinishAddTast:(TaskItem*)taskItem
{
//    [_tasks addObject:taskItem];
//    [_table reloadData];
}

#pragma mark - Action

- (IBAction)checkTask:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    CDAlert *item = [_alretResults.fetchedObjects objectAtIndex:button.tag];
    item.isCheck  = !item.isCheck;
    [[AppDelegate sharedAppDelegate] saveContext];
}

#pragma mark - CoreData

- (NSFetchedResultsController*)alretResults
{
    if (_alretResults == nil) {
        NSString *entityName = @"CDAlert";
        AppDelegate *_appDelegate = [AppDelegate sharedAppDelegate];
        
        NSString *cacheName = [NSString stringWithFormat:@"%@",entityName];
        [NSFetchedResultsController deleteCacheWithName:cacheName];

        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:_appDelegate.managedObjectContext];
        
        
        NSSortDescriptor *sort0 = [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES];
        NSArray *sortList = [NSArray arrayWithObjects:sort0, nil];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"created != nil"];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = entity;
        fetchRequest.fetchBatchSize = 20;
        fetchRequest.sortDescriptors = sortList;
        fetchRequest.predicate = predicate;
        _alretResults = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                   managedObjectContext:_appDelegate.managedObjectContext
                                                                     sectionNameKeyPath:nil
                                                                              cacheName:cacheName];
        _alretResults.delegate = self;
        
        NSError *error = nil;
        [_alretResults performFetch:&error];
        if (error) {
            NSLog(@"%@ core data error: %@", [self class], error.localizedDescription);
        }
        
        if ([_alretResults.fetchedObjects count] == 0) {
            NSLog(@"add 4 item");
            
            //read file
            NSString* path = [[NSBundle mainBundle] pathForResource:@"task_data" ofType:@"html"];
            if (path)
            {
                NSString* content = [NSString stringWithContentsOfFile:path
                                                              encoding:NSUTF8StringEncoding
                                                                 error:NULL];
                NSArray *totalTask = [content componentsSeparatedByString:@"~"];
                for (int i = 0 ; i < [totalTask count]; i++) {
                    CDAlert *cdAlert = (CDAlert *)[NSEntityDescription insertNewObjectForEntityForName:@"CDAlert" inManagedObjectContext:_appDelegate.managedObjectContext];
                    
                    cdAlert.canDel = NO;
                    cdAlert.isCheck = NO;
                    
                    //
                    NSString *strContent = [totalTask objectAtIndex:i];
                    NSArray *tempContent = [strContent componentsSeparatedByString:@"|"];
                    
                    cdAlert.name = [tempContent objectAtIndex:0];
                    cdAlert.content = [tempContent objectAtIndex:1];
                    
                    cdAlert.created = [[NSDate date] timeIntervalSince1970];
                    cdAlert.dateTime = -1.0;
                    cdAlert.dateAlert = -1.0;
                    cdAlert.typeDateAlert = AlertTypeOff;
                    cdAlert.isAlertOn = NO;
                    
                    [_appDelegate saveContext];
                }
                
            } else {
                NSLog(@"path error");
            }
            
        } else {
            //NSLog(@"total item : %lu",(unsigned long)[_alretResults.fetchedObjects count]);
        }
        
        [_table reloadData];
        _isLoadCoreData = NO;


    }
    return _alretResults;
      
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [_table reloadData];
    if (!_isLoadCoreData) {
        [self creatAlert];
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
}


#pragma mark - Alert for task

- (void)creatAlert
{
    //NSLog(@" -- > Before add Local Notification : %lu",(unsigned long)[[[UIApplication sharedApplication] scheduledLocalNotifications] count]);
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    //NSLog(@"Remove     Local Notification : %lu",(unsigned long)[[[UIApplication sharedApplication] scheduledLocalNotifications] count]);
    
    
    
    for (CDAlert *cdAlert in _alretResults.fetchedObjects) {
        if (!cdAlert.isCheck) {            
            NSTimeInterval dateAlertTemp = ((int) cdAlert.dateAlert / 60) * 60;
            
            if (dateAlertTemp < cdAlert.dateTime && dateAlertTemp > [[NSDate date] timeIntervalSince1970]) {
                
                
                NSDate *dateAlert = [NSDate dateWithTimeIntervalSince1970:dateAlertTemp];
                
                UILocalNotification *localNotif = [[UILocalNotification alloc] init];
                if (localNotif == nil)
                    return;
                localNotif.fireDate = dateAlert;
                
                // Notification details
                localNotif.alertBody = cdAlert.name;
                // Set the action button
//                localNotif.alertAction = @"View";
                
                localNotif.soundName = UILocalNotificationDefaultSoundName;
                localNotif.applicationIconBadgeNumber = 0;
                
                // Specify custom data for the notification
                NSArray *key = @[@"name",@"content",@"created"];
                NSArray *value = @[cdAlert.name,cdAlert.content,[NSString stringWithFormat:@"%f",cdAlert.created]];
                NSDictionary *infoDict = [NSDictionary dictionaryWithObjects:value forKeys:key];
                localNotif.userInfo = infoDict;
                
                // Schedule the notification
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
                
                //NSLog(@"add local notification");
            }
            
        }
    }
    
    //NSLog(@"After add  Local Notification : %lu",(unsigned long)[[[UIApplication sharedApplication] scheduledLocalNotifications] count]);
    
}

@end














