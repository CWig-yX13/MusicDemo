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
@property (nonnull,strong) NSString *musicName;

/*!
 音频文件的路径
 */
@property (nonnull,strong) NSString *musicUrl;

/*!
 歌词
 */
@property (nonnull,strong) NSDictionary *lrcDict;

/*!
 歌词时间表(排序后)
 */
@property (nonnull,strong) NSArray *lrcTimesArr;

/*!
 MusicModel初始化方法
 */
- (instancetype __nonnull)initWithMusicName:(NSString * __nonnull)name MusciUrl:(NSString * __nonnull)url LrcDict:(NSDictionary * __nonnull)lrcDcit;

/*!
 歌词转字典
 */
+ (NSDictionary * __nonnull)getLrcDictWithMusciLrcFileName:(NSString * __nonnull)fileName;

@end
