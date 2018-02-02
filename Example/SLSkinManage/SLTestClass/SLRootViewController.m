//
//  SLRootViewController.m
//  SLSkinManage_Example
//
//  Created by Touker on 2018/2/2.
//  Copyright © 2018年 lishuailibertine. All rights reserved.
//

#import "SLRootViewController.h"

@interface SLRootViewController ()
@property (weak, nonatomic) IBOutlet UITableView *skinTableView;

@end

@implementation SLRootViewController
+ (id)createRootViewController
{
    SLRootViewController * rootViewController =[SLRootViewController createFromStoryboardWithStoryboardID:@"SLRootViewController" storyboardName:@"SLRootViewController" bundleName:nil];
    return rootViewController;
}
+ (instancetype)createFromStoryboardWithStoryboardID:(NSString *)aStoryboardID storyboardName:(NSString *)aStoryboardName  bundleName:(NSString *)aBundleName {
    NSBundle *bundle = [self getBundleWithBundleName:aBundleName];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:aStoryboardName bundle:bundle];
    return [storyboard instantiateViewControllerWithIdentifier:aStoryboardID];
}

+ (NSBundle *)getBundleWithBundleName:(NSString *)aBundleName {
    NSBundle *bundle = [NSBundle mainBundle];
    if (aBundleName.length) {
        bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:aBundleName withExtension:@"bundle"]];
    }
    return bundle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    self.skinTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view.
}
#pragma mark -
#pragma mark -代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"rootViewControllerCell"];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
#pragma mark -行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
#pragma mark -区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

@end
