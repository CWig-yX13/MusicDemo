//
//  AudioPlayer.h
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer : NSObject

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

/*!
 播放器单例
 */
+ (instancetype)shareInstace;

@end
