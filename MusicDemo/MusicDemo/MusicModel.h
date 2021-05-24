//
//  MusicModel.h
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

/*!
 歌名
 */
@property (nonatomic,nonnull,strong) NSString *musicName;

/*!
 音频文件的路径
 */
@property (nonatomic,nonnull,strong) NSURL *musicUrl;

/*!
 歌词
 */
@property (nonatomic,nonnull,strong) NSDictionary *lrcDict;

/*!
 歌词时间表(排序后)
 */
@property (nonatomic,nonnull,strong) NSArray *lrcTimesArr;

/*!
 MusicModel初始化方法
 */
- (instancetype __nonnull)initWithMusicName:(NSString * __nonnull)musicName MusicFileName:(NSString * __nonnull)musicFileName LrcFileName:(NSString * __nonnull)lrcFileName;

@end
