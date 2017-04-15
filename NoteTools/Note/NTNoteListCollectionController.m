//
//  NTNoteListCollectionController.m
//  NoteTools
//
//  Created by wanglei on 17/3/30.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTNoteListCollectionController.h"
#import "NTNoteDataModel.h"
#import "NTNoteListCell.h"
#import "NTNoteDetailViewController.h"

@interface NTNoteListCollectionController ()<noteListCellDelegate>

@property (nonatomic, strong) RLMResults *noteList;

@end

@implementation NTNoteListCollectionController

static NSString * const reuseIdentifier = @"noteList";

- (instancetype)init
{
    //先创建一个流式布局对象,否则报错
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 150);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    //返回
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    self.collectionView.backgroundColor = [UIColor whiteColor];

    // Register cell classes
    [self.collectionView registerClass:[NTNoteListCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    RLMResults *noteList = [NTNoteDataModel allObjects];
    self.noteList = noteList;
    [self.collectionView reloadData];
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

#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.noteList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *nib = [UINib nibWithNibName:@"NTNoteListCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    NTNoteListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    NTNoteDataModel *note = [self.noteList objectAtIndex:indexPath.item];
    cell.titleLabel.text = note.title;
//    NSData *data = [NTUtilities loadContentFromLocal:note.content];
//    NSAttributedString *content = [[NSAttributedString alloc]initWithData:data options:@{NSDocumentTypeDocumentAttribute : NSRTFDTextDocumentType} documentAttributes:nil error:nil];
//    NSString *contents = [content string];
    cell.descriptionLabel.text = note.contentString;
    cell.editTimeLabel.text = [NTUtilities yyyyMMddTimeConvertFromDate:note.editDate];
    cell.iconImage.image = [UIImage imageNamed:@"123"];
    //    cell.backgroundColor = indexPath.item % 2 == 0 ? [UIColor redColor] : [UIColor yellowColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NTNoteDetailViewController *noteDetailVC = [[NTNoteDetailViewController alloc]init];
    NTNoteDataModel *note = [self.noteList objectAtIndex:indexPath.item];
    noteDetailVC.noteId = note.noteId;
    [self.navigationController pushViewController:noteDetailVC animated:YES];
}

-(void)noteListCell:(NTNoteListCell *)cell longPressCellToEdit:(NSString *)title
{
    UIAlertController *noteCell = [UIAlertController alertControllerWithTitle:@"文件：" message:title preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *noteDelete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *noteCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [noteCell addAction:noteDelete];
    [noteCell addAction:noteCancel];
    [self presentViewController:noteCell animated:YES completion:nil];
    
}

-(void)deleteNoteFromDataBase
{
    //TODO:删除文章内容
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
