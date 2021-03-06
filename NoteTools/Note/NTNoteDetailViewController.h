//
//  NTNoteDetailViewController.h
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTBaseViewController.h"

@interface NTNoteDetailViewController : NTBaseViewController

@property (nonatomic, strong) NSString *noteTitle;
@property (nonatomic, assign) NSString *noteId;
@property (nonatomic, assign) BOOL isNewNote;

@end
