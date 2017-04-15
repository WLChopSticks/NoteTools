//
//  NTNoteDataModel.h
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <Realm/Realm.h>
#import "NTNoteImageEmbeddedModel.h"

@interface NTNoteDataModel : RLMObject

@property NSString *noteId;
@property NSString *title;
@property NSString *contentString;
@property NSDate *editDate;
@property NSArray *images;
@property RLMArray<NTNoteImageEmbeddedModel *><NTNoteImageEmbeddedModel> *imagesEmbedded;
@property NSString *imagesSavedPath;


@end

