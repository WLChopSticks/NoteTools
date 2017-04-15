//
//  NTNoteListCell.h
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NTNoteListCell;
@protocol noteListCellDelegate <NSObject>

-(void)noteListCell: (NTNoteListCell *)cell longPressCellToEdit: (NSString *)title;

@end

@interface NTNoteListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *editTimeLabel;

@property (weak, nonatomic) id<noteListCellDelegate> delegate;


@end
