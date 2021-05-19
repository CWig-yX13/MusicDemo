//
//  MusicListTableViewController.m
//  MusicDemo
//
//  Created by 卢浩 on 16/4/9.
//  Copyright © 2016年 卢浩. All rights reserved.
//

#import "MusicListTableViewController.h"
#import "MusicModel.h"

@interface MusicListTableViewController ()

/*!
 保存音乐的数组
 */
@property (nonatomic,strong,nonnull) NSMutableArray *musicArray;

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
    
    //创建音乐,并添加到音乐数组
    MusicModel *music1 = [[MusicModel alloc]initWithMusicName:@"情非得已" MusicFileName:@"情非得已.mp3" LrcDict:[MusicModel getLrcDictWithMusciLrcFileName:@"情非得已.lrc"]];
//    NSLog(@"%@",music1);
    MusicModel *musci2 = [[MusicModel alloc]initWithMusicName:@"背对背拥抱" MusicFileName:@"林俊杰-背对背拥抱.mp3" LrcDict:[MusicModel getLrcDictWithMusciLrcFileName:@"林俊杰-背对背拥抱.lrc"]];
    MusicModel *music3 = [[MusicModel alloc] initWithMusicName:@"偶阵雨" MusicFileName:@"梁静茹-偶阵雨.mp3" LrcDict:[MusicModel getLrcDictWithMusciLrcFileName:@"梁静茹-偶阵雨.lrc"]];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
