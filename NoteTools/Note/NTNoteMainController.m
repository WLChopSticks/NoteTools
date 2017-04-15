//
//  NTNoteMainController.m
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTNoteMainController.h"
#import "NTNoteDetailViewController.h"
#import "NTNoteListCollectionController.h"

@interface NTNoteMainController ()

@property (nonatomic, strong) NTNoteListCollectionController *noteListVC;

@end

@implementation NTNoteMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialNoteListCollectionController];
    

    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNote)];
    self.navigationItem.rightBarButtonItem = addItem;

}

-(void)addNewNote
{
    NTNoteDetailViewController *noteDetailVC = [[NTNoteDetailViewController alloc]init];
    noteDetailVC.isNewNote = YES;
    [self.navigationController pushViewController:noteDetailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialNoteListCollectionController
{
    NTNoteListCollectionController *noteListVC = [[NTNoteListCollectionController alloc]init];
    self.noteListVC = noteListVC;
    [self addChildViewController:noteListVC];
    [self.view addSubview:noteListVC.view];

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
