//
//  MusicListTableViewController.m
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import "MusicListTableViewController.h"
#import "MusicModel.h"
#import "MusicPlayerViewController.h"

@interface MusicListTableViewController ()

/*!
 保存音乐的数组
 */
@property (nonatomic,strong,nonnull) NSMutableArray *musicArray;

@property (nonatomic,strong) NSString *musicName;

@end

@implementation MusicListTableViewController

/*!
 音乐数组懒加载
 */
- (NSMutableArray *)musicArray{
    if (_musicArray == nil) {
        _musicArray = [NSMutableArray array];
    }
    return _musicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.musicName = nil;
    
    //创建音乐,并添加到音乐数组
    MusicModel *music1 = [[MusicModel alloc]initWithMusicName:@"情非得已" MusicFileName:@"情非得已.mp3" LrcFileName:@"情非得已.lrc"];
//    NSLog(@"%@",music1);
    MusicModel *musci2 = [[MusicModel alloc]initWithMusicName:@"背对背拥抱" MusicFileName:@"背对背拥抱.mp3" LrcFileName:@"背对背拥抱.lrc"];
    MusicModel *music3 = [[MusicModel alloc] initWithMusicName:@"偶阵雨" MusicFileName:@"偶阵雨.mp3" LrcFileName:@"偶阵雨.lrc"];
    [self.musicArray addObjectsFromArray:@[music1,musci2,music3]];
}

//内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musicArray.count;
}

//Cell,每行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicNameCell" forIndexPath:indexPath];
    MusicModel *music = self.musicArray[indexPath.row];
    cell.textLabel.text = music.musicName;
    return cell;
}

//跳转时传输数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MusicPlayerViewController *musicPlayerVC = segue.destinationViewController;
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    //判断是够跟上次打开的是相同的歌曲
    MusicModel *music = self.musicArray[indexPath.row];
    if ([self.musicName isEqualToString:music.musicName]) {
        musicPlayerVC.isSame = YES;
    }else{
        musicPlayerVC.isSame = NO;
    }
    self.musicName = music.musicName;
    musicPlayerVC.musicArray = self.musicArray;
    musicPlayerVC.index = indexPath.row;
    musicPlayerVC.MusicNameChangeBlock = ^(NSString *name){
        self.musicName = name;
        NSLog(@"%@",name);
    };
}

@end
