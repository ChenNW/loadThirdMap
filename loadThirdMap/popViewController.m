//
//  popViewController.m
//  loadThirdMap
//
//  Created by Cnw on 2018/3/16.
//  Copyright © 2018年 Cnw. All rights reserved.
//

#import "popViewController.h"
#import "popTableViewCell.h"
#import "popModel.h"

@interface popViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 数组 */
@property(nonatomic ,strong)NSMutableArray *dataArray;
@end

@implementation popViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.f green:(arc4random()%256)/255.f blue:(arc4random()%256)/255.f alpha:1];
    NSArray * array = @[@{@"title":@"扫一扫",@"image":@"img_chedai"},@{@"title":@"添加朋友",@"image":@"img_fangdai"},@{@"title":@"摇一摇",@"image":@"img_jingying"},@{@"title":@"扫码支付",@"image":@"img_fangdai"}];
//    for (int i=0; i<array.count; i++) {
////        popModel * model = [popModel mj_objectWithKeyValues:array[i]];
//        [self.dataArray addObject:model];
//    }
    

   
    [self addTableView];
}
-(void)addTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID= @"cell";
    
    popTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell==nil) {
        cell=[[popTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.popModel = _dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hhaahha");
    
}



-(CGSize)preferredContentSize
{
    if (self.presentingViewController) {
        CGSize size = CGSizeMake(300 , 200);
        return size;
    }else{
        return [super preferredContentSize];
    }
}
-(void)setPreferredContentSize:(CGSize)preferredContentSize
{
    super.preferredContentSize = preferredContentSize;
}

@end
