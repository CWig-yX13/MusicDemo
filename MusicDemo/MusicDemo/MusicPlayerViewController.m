//
//  MusicPlayerViewController.m
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "MusicLrcTableViewCell.h"
#import "AudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayerViewController ()<UITableViewDataSource>

/*!
 歌词TableView
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/*!
 总时长
 */
@property (weak, nonatomic) IBOutlet UILabel *allTimeLable;

/*!
 已播放的时长
 */
@property (weak, nonatomic) IBOutlet UILabel *alreadyTimeLable;

/*!
 音量条
 */
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;

/*!
 播放进度条
 */
@property (weak, nonatomic) IBOutlet UISlider *scheduleSlider;

/*!
 歌词字典
 */
@property (nonatomic,strong) NSDictionary *lrcDict;

@end

@implementation MusicPlayerViewController

/*!
 歌词字典懒加载
 */
- (NSDictionary *)lrcDict{
    if (_lrcDict == nil) {
        _lrcDict = self.music.lrcDict;
    }
    return _lrcDict;
}

//播放暂停
- (IBAction)playOrStopAction:(UIButton *)sender {
    
}

//上一曲
- (IBAction)backAction:(UIButton *)sender {
    
}

//下一曲
- (IBAction)nextAction:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置视图标题
    self.navigationItem.title = self.music.musicName;
    
    //设置TableView代理
    self.tableView.dataSource = self;
    //设置TableView行之间分割线样式,无
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (!self.isSame) {
        //初始化音乐播放器
        [AudioPlayer shareInstace].audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:self.music.musicUrl error:nil];
        //音量
        [AudioPlayer shareInstace].audioPlayer.volume = 1;
        //循环播放次数(循环)
        [AudioPlayer shareInstace].audioPlayer.numberOfLoops = -1;
        //播放进度
        [AudioPlayer shareInstace].audioPlayer.currentTime = 0;
        //预播放
        [[AudioPlayer shareInstace].audioPlayer prepareToPlay];
        //播放
        [[AudioPlayer shareInstace].audioPlayer play];
    }
    
    //添加计时器
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    //给两个滚动条添加事件,当滚动时,对应改变播放进度与音量
    [self.volumeSlider addTarget:self action:@selector(volumeChanged) forControlEvents:(UIControlEventValueChanged)];
    [self.scheduleSlider addTarget:self action:@selector(scheduleChanged) forControlEvents:(UIControlEventValueChanged)];
}

//音量改变
- (void)volumeChanged{
    [AudioPlayer shareInstace].audioPlayer.volume = self.volumeSlider.value;
}

//播放进度改变
- (void)scheduleChanged{
    //获取总时间
    double allTime = [AudioPlayer shareInstace].audioPlayer.duration;
    //通过比例得到当前的播放时间
    double changedTime = allTime * self.scheduleSlider.value;
    [AudioPlayer shareInstace].audioPlayer.currentTime = changedTime;
}

//计时器方法
- (void)timerAction{
    [self setTimeLable];
    [self setScheduleSlider];
    [self scrollLrcCell];
}

//设置播放时间的两个Lable
- (void)setTimeLable{
    //总时间
    NSInteger allTime = [AudioPlayer shareInstace].audioPlayer.duration;
    //当前时间
    NSInteger alreadyTime = [AudioPlayer shareInstace].audioPlayer.currentTime;
    self.allTimeLable.text = [NSString stringWithFormat:@"%02ld:%02ld",allTime/60,allTime%60];
    self.alreadyTimeLable.text = [NSString stringWithFormat:@"%02ld:%02ld",alreadyTime/60,alreadyTime%60];
}

//随着播放,播放进度条的滚动
- (void)setScheduleSlider{
    //获取当前时间除总时间的比例
    float value = [AudioPlayer shareInstace].audioPlayer.currentTime/[AudioPlayer shareInstace].audioPlayer.duration;
    self.scheduleSlider.value = value;
}

//随着播放,歌词相应滚动
- (void)scrollLrcCell{
    //当前播放时间
    double alreadyTime = [AudioPlayer shareInstace].audioPlayer.currentTime;
    //将时间转化为字符串,方便对比
    NSString *timeStr = [NSString stringWithFormat:@"%.2f",alreadyTime];
    //判断歌词时间列表是够存在这个时间
    if ([self.music.lrcTimesArr containsObject:timeStr]) {
        //获取时间对应的歌词行数
        NSInteger row = [self.music.lrcTimesArr indexOfObject:timeStr];
        //滚动到当前行
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:(UITableViewScrollPositionMiddle) animated:YES];
    }
}

//内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.music.lrcTimesArr.count;
}

//Cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicLrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicLrcCell"];
    cell.lrcLable.text = self.lrcDict[self.music.lrcTimesArr[indexPath.row]];
    return cell;
}

@end
