//
//  NTBaseViewController.m
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTBaseViewController.h"

@interface NTBaseViewController ()

@end

@implementation NTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"viewDidLoad--%@", [self class]);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewAppear--%@", [self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
