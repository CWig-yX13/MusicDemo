//
//  MusicPlayerViewController.h
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPlayerViewController : UIViewController

@property (nonatomic,strong,nonnull) NSArray *musicArray;

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) BOOL isSame;

@property (nonatomic,copy) void(^ __nonnull MusicNameChangeBlock)(NSString *__nonnull musicName);

@end
