//
//  NTNoteDetailViewController.m
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTNoteDetailViewController.h"
#import "NTNoteDataModel.h"


@interface NTNoteDetailViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate>

@property (nonatomic, weak) UITextField *titleView;
@property (nonatomic, weak) UITextView *contentView;
@property NTNoteDataModel *noteModel;
@property (nonatomic, assign) CGRect cursorRect;/**当前光标的位置*/
@property (nonatomic, weak) UIToolbar *editAccessoryBar;



@property (nonatomic, strong) NSMutableArray *imageEmbeddedArr;
@property (nonatomic, strong) NSMutableDictionary *imagesDict;
@property (nonatomic, strong) NSString *contentString;

@end

@implementation NTNoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageEmbeddedArr = [NSMutableArray array];
    self.contentString = @"";
    self.imagesDict = [NSMutableDictionary dictionary];
    
    [self decorateUI];
    BOOL findResult = NO;
    if (self.noteModel == nil) {
       findResult = [self noteLoadFromDataBase];
    }
    if (self.noteId != nil) {
        self.titleView.text = self.noteModel.title;
        [self layoutNoteContent];
    }
    [self addNotificationObserver];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //如果是新创建的笔记, 则进入时弹出键盘
    if (self.noteId == nil) {
        [self.contentView becomeFirstResponder];
        long long noteIdOrder = [[[NSUserDefaults standardUserDefaults]objectForKey:@"noteIdOrder"]longLongValue];
        noteIdOrder += 1;
        self.noteId = [NSString stringWithFormat:@"%lld",noteIdOrder];
        [[NSUserDefaults standardUserDefaults]setObject:@(noteIdOrder) forKey:@"noteIdOrder"];
    }
}

- (void)decorateUI
{
    
    [self customizeNavigationBar];
    
    UITextField *titleView = [[UITextField alloc]init];
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    UIView *seperateLine = [[UIView alloc]init];
    seperateLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:seperateLine];
    
    UITextView *contentView = [[UITextView alloc]init];
    self.contentView = contentView;
    contentView.delegate = self;
    contentView.layoutManager.allowsNonContiguousLayout = NO;
    contentView.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:contentView];
    
    //加载编辑辅助条
    [self customizeEditAccessoryBar];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seperateLine.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.editAccessoryBar.mas_top);
    }];
}

- (void)customizeNavigationBar
{
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishItemClicking)];
    self.navigationItem.rightBarButtonItem = finishItem;
}

-(void)customizeEditAccessoryBar
{
    UIToolbar *editAccessoryBar = [[UIToolbar alloc]init];
    self.editAccessoryBar = editAccessoryBar;
    [self.view addSubview:editAccessoryBar];
    
    UIBarButtonItem *imageBtn = [[UIBarButtonItem alloc]initWithTitle:@"图片" style:UIBarButtonItemStylePlain target:self action:@selector(insertImageBtnClicking)];
    
    UIBarButtonItem *placeHolderBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *hideKeyboardBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboardBtnClicking)];
    
    editAccessoryBar.items = @[imageBtn,placeHolderBtn,hideKeyboardBtn];
    
    [editAccessoryBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
}

-(void)addNotificationObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma -mark 键盘通知的监听
-(void)keyBoardWillShowNotification: (NSNotification *)notice
{
    NSDictionary *userInfo = notice.userInfo;
    CGRect keyboradFrame = [userInfo[@"UIKeyboardBoundsUserInfoKey"]CGRectValue];
    [self.editAccessoryBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-keyboradFrame.size.height);
    }];
}

-(void)keyBoardWillHideNotification: (NSNotification *)notice
{
    [self.editAccessoryBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

-(void)insertImageBtnClicking
{
    NSLog(@"点击了加载图片");
    
    //TODO: 增加从图库中选择图片以及调用相机拍照
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else {
        NSLog(@"无法打开图库, 因为不支持图库");
    }
}

-(void)CallCameraBtnClicking
{
    NSLog(@"点击了调用摄像头");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc]init];
        cameraPicker.delegate = self;
        cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:cameraPicker animated:YES completion:nil];
    } else {
        NSLog(@"无法打开相机, 因为不支持相机");
    }
    
}

-(void)hideKeyboardBtnClicking
{
    NSLog(@"点击了隐藏键盘按钮");
    [self.titleView endEditing:YES];
    [self.contentView endEditing:YES];
}


- (void)finishItemClicking
{
    NSLog(@"完成");
    
    //如果noteTitle没有传入参数, 则认为新创建的笔记, 否则更新笔记内容不创建新的笔记
    if (self.isNewNote) {
        [self noteSaveToDataBase];
    } else {
        [self noteUpdateToDataBase];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark 数据库处理
-(void)noteSaveToDataBase
{
    NTNoteDataModel *noteModel = [[NTNoteDataModel alloc]init];
    noteModel.noteId = self.noteId;
    noteModel.title = self.titleView.text;
    noteModel.editDate = [NSDate date];
    noteModel.contentString = self.contentString;
    noteModel.images = self.imageEmbeddedArr;
    
    NSData *data = [NTUtilities returnDataWithDictionary:self.imagesDict];
    NSString *filePath = [NTUtilities saveContentToLocalWithFileName:self.noteId andData:data];
    noteModel.imagesSavedPath = filePath;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:noteModel];
    [realm commitWriteTransaction];
}

-(BOOL)noteLoadFromDataBase
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"noteId = %@",self.noteId];
    RLMResults *result = [NTNoteDataModel objectsWithPredicate:pred];
    
    NTNoteDataModel *noteModel = result.firstObject;
    self.noteModel = noteModel;
    self.contentString = self.noteModel.contentString;
    self.imageEmbeddedArr = [NSMutableArray arrayWithArray:self.noteModel.images];
    NSData *data = [NTUtilities loadContentFromLocalWithFileName:self.noteId];
    self.imagesDict = [NSMutableDictionary dictionaryWithDictionary:[NTUtilities returnDictionaryWithData:data]];
    
    return result.count > 0;
}

-(void)noteUpdateToDataBase
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    self.noteModel.title = self.titleView.text;
    self.noteModel.editDate = [NSDate date];
    self.noteModel.contentString = self.contentString;
    self.noteModel.images = self.imageEmbeddedArr;
    
    NSData *data = [NTUtilities returnDataWithDictionary:self.imagesDict];
    NSString *filePath = [NTUtilities saveContentToLocalWithFileName:self.noteId andData:data];
    self.noteModel.imagesSavedPath = filePath;

    self.noteModel.editDate = [NSDate date];
    [realm commitWriteTransaction];
}

#pragma -mark 图库选择图片处理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //Before adding the image, we save the content string first.
    NSURL *referenceURL = info[@"UIImagePickerControllerReferenceURL"];
    NSString *reference = [referenceURL absoluteString];
    NSRange range = [reference rangeOfString:@"id="];
    NSString *imageId = [reference substringFromIndex:(range.location + range.length)];
    
    CGFloat cursorLocation = self.contentView.selectedRange.location;
    NTNoteImageEmbeddedModel *imageModel = [[NTNoteImageEmbeddedModel alloc]init];
    imageModel.location = cursorLocation;
    imageModel.width = 300;
    imageModel.height = 500;
    imageModel.imageId = imageId;
    [self.imageEmbeddedArr addObject:imageModel];
    
    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imagesDict setObject:chosenImage forKey:imageId];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //TODO: 支持选择多种格式图片
    
    //get original image
//    UIImage *chosenImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [self insertChosenImage:chosenImage];
    [self layoutNoteContent];
    //插入图片后自动滚到最后
    [self.contentView scrollRangeToVisible:NSMakeRange(self.contentView.text.length, 1)];
    
}

-(void)layoutNoteContent
{
    NSMutableAttributedString *noteContent = [[NSMutableAttributedString alloc]initWithString:self.contentString == nil ? @"" : self.contentString];
    for (NTNoteImageEmbeddedModel *imageModel in self.imageEmbeddedArr) {
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        attachment.image = [self.imagesDict objectForKey:imageModel.imageId];
        attachment.bounds = CGRectMake(0, 0, imageModel.width, imageModel.height);
        NSAttributedString *addictiveStr = [NSAttributedString attributedStringWithAttachment:attachment];
        [noteContent appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n"]];
        [noteContent insertAttributedString:addictiveStr atIndex:imageModel.location];
        [noteContent appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n"]];

    }
    self.contentView.attributedText = noteContent;
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.contentString = textView.text;
    NSLog(@"%@",textView.attributedText);
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
