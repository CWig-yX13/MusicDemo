//
//  AudioPlayer.m
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import "AudioPlayer.h"

@implementation AudioPlayer

+ (instancetype)shareInstace{
    static AudioPlayer *manager = nil;
    @synchronized (self) {
        if (manager == nil) {
            manager = [AudioPlayer new];
        }
    }
    return manager;
}

@end
