//
//  MusicModel.m
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

/*!
 MusicModel初始化方法
 */
- (instancetype __nonnull)initWithMusicName:(NSString * __nonnull)musicName MusicFileName:(NSString * __nonnull)musicFileName LrcFileName:(NSString * __nonnull)lrcFileName{
    if (self = [super init]) {
        _musicName = musicName;
        //根据音乐文件名获取文件路径
        _musicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:musicFileName ofType:nil]];
        //调用方法,根据歌词文件名,获取歌词字典
        _lrcDict = [self getLrcDictWithMusciLrcFileName:lrcFileName];
        //调用方法,根据歌词字典获取排序后的歌词时间表
        _lrcTimesArr = [self getLrcSortTimesArrWithLrcDict:_lrcDict];
    }
    return self;
}

/*!
通过字典获取排序后的歌词时间表
 */
- (NSArray *)getLrcSortTimesArrWithLrcDict:(NSDictionary *)lrcDict{
    NSMutableArray *timesArr = lrcDict.allKeys.mutableCopy;
    [timesArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        float num1 = [obj1 floatValue];
        float num2 = [obj2 floatValue];
        if (num1 > num2) {
            return NSOrderedDescending;
        }else if (num1 == num2){
            return NSOrderedSame;
        }else{
            return NSOrderedAscending;
        }
    }];
    return timesArr;
}

/*!
 歌词转字典
 */
- (NSDictionary * __nonnull)getLrcDictWithMusciLrcFileName:(NSString * __nonnull)fileName{
    //根据文件路径,获取歌词
    NSString *lrcStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:fileName ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    //创建字典保存一段段歌词
    NSMutableDictionary *lrcDict = [NSMutableDictionary dictionary];
    //按句取出歌词
    NSArray *arr1 = [lrcStr componentsSeparatedByString:@"\n"];
    for (NSString *str1 in arr1) {
        //按]分开歌词与时间
        NSArray *arr2 = [str1 componentsSeparatedByString:@"]"];
        //第一行对应的数组只有1一个元素,排除掉这行无用数据
        if (arr2.count > 1) {
            //获取歌词
            NSString *lrc = arr2.lastObject;
            //获取时间
            NSString *timeStr = arr2.firstObject;
            //分开分,秒
            NSArray *timeArr = [timeStr componentsSeparatedByString:@":"];
            //计算总秒数
            float second = [[timeArr.firstObject substringFromIndex:1] floatValue] * 60 + [timeArr.lastObject floatValue];
            //转化为字符串格式
            NSString *time = [NSString stringWithFormat:@"%.2f",second];
            //将这段歌词添加到歌词字典
            [lrcDict setObject:lrc forKey:time];
        }
    }
    return lrcDict;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@", self.musicName,self.musicUrl,self.lrcDict,self.lrcTimesArr];
}

@end
