//
//  TMHomeViewController.m
//  TMExam
//
//  Created by ZHANG SHI GUANG on 13-6-29.
//  Copyright (c) 2013年 ZHANG SHI GUANG. All rights reserved.
//

#import "TMHomeViewController.h"
#import "TMTestViewController.h"
#import "TMScoreViewController.h"
#import "TMTestRecord.h"
#import "TMTestRecordManager.h"
@interface TMHomeViewController ()

@end

@implementation TMHomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"功能选单";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HomeViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"模拟考试";
            break;
        case 1:
            cell.textLabel.text = @"培训讲义";
            break;
        case 2:
            cell.textLabel.text = @"得分统计";
            break;
        case 3:
            cell.textLabel.text = @"油田新闻";
            break;
            
        default:
            break;
    }
        
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            TMTestViewController *testViewController = [[TMTestViewController alloc] init];
            [self.navigationController pushViewController:testViewController animated:YES];
            break;
        }
        case 1:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"演示版没有此功能"
                                                               delegate:nil
                                                      cancelButtonTitle:@"知道了"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
        case 2:
        {
            // 拼数据
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:10];
            NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:10];
            [dict setObject:data forKey:@"data"];
            NSMutableDictionary *record = [[NSMutableDictionary alloc] initWithCapacity:2];
            
            NSArray *array = [[[TMTestRecordManager sharedManager] type2RecordArrayDict] objectForKey:[NSNumber numberWithInt:RECORD_TYPE_SINGLE_SELECTION]];
            int cnt = array.count;
            int right = [[[[TMTestRecordManager sharedManager] type2RightRecDict] objectForKey:[NSNumber numberWithInt:RECORD_TYPE_SINGLE_SELECTION]] intValue];
            [record setObject:@"正确题目" forKey:@"title"];
            [record setObject:[NSNumber numberWithInt:right] forKey:@"value"];
            [data addObject:record];

            record = [[NSMutableDictionary alloc] initWithCapacity:2];
            [record setObject:@"错误题目" forKey:@"title"];
            [record setObject:[NSNumber numberWithInt:cnt - right] forKey:@"value"];
            [data addObject:record];
            
            // 显示
            TMScoreViewController *scoreViewController = [[TMScoreViewController alloc] initWithDict:dict];
            [self.navigationController pushViewController:scoreViewController animated:YES];
            break;
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                                message:@"演示版没有此功能"
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"知道了"
//                                                      otherButtonTitles:nil, nil];
//            [alertView show];
            break;
        }
        case 3:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"演示版没有此功能"
                                                               delegate:nil
                                                      cancelButtonTitle:@"知道了"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
            
        default:
            break;
    }

    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
