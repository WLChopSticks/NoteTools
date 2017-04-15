//
//  NTNoteListCell.m
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTNoteListCell.h"

@implementation NTNoteListCell

-(void)setTitleLabel:(UILabel *)titleLabel
{
    _titleLabel = titleLabel;
    
    UILongPressGestureRecognizer *panGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressNoteCell)];
    [self addGestureRecognizer:panGesture];
}

-(void)longPressNoteCell
{
    if ([self.delegate respondsToSelector:@selector(noteListCell:longPressCellToEdit:)]) {
        [self.delegate noteListCell:self longPressCellToEdit:self.titleLabel.text];
    }
}

@end
