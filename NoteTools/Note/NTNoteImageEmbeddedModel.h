//
//  NTNoteImageEmbeddedModel.h
//  NoteTools
//
//  Created by wanglei on 17/3/31.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import <Realm/Realm.h>

@interface NTNoteImageEmbeddedModel : RLMObject

@property NSString *imageId;
@property NSString *imagePath;
@property float location;
@property CGFloat width;
@property CGFloat height;

@end
RLM_ARRAY_TYPE(NTNoteImageEmbeddedModel)
