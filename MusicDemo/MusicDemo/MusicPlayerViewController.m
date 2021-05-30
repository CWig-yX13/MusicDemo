//
//  MusicPlayerViewController.m
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "MusicLrcTableViewCell.h"

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
    
    //设置代理
    self.tableView.dataSource = self;
    //设置行之间分割线样式,无
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
