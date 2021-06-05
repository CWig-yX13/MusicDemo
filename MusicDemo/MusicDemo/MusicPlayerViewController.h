//
//  MusicPlayerViewController.h
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MusicPlayerViewController : UIViewController

@property (nonatomic,strong) MusicModel *music;

@property (nonatomic,assign) BOOL isSame;

@end
