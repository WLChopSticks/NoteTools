//
//  NTNoteDataModel.m
//  NoteTools
//
//  Created by wanglei on 17/3/29.
//  Copyright © 2017年 wanglei. All rights reserved.
//

#import "NTNoteDataModel.h"

@implementation NTNoteDataModel

+(NSArray<NSString *> *)ignoredProperties
{
    return @[@"images"];
}

-(void)setImages:(NSArray *)images
{
    [self.imagesEmbedded removeAllObjects];
    for (NTNoteImageEmbeddedModel *imageModel in images) {
        [self.imagesEmbedded addObject:imageModel];
    }
}

-(NSArray *)images
{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0; i < self.imagesEmbedded.count; i++) {
        [imageArr addObject:[self.imagesEmbedded objectAtIndex:i]];
    }
    return imageArr;
}

@end
