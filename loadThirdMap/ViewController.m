//
//  ViewController.m
//  loadThirdMap
//
//  Created by Cnw on 2018/3/15.
//  Copyright © 2018年 Cnw. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "popViewController.h"
@interface ViewController ()<UIPopoverPresentationControllerDelegate>
/** uibutton */
@property(nonatomic ,strong)UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 66*2)/3;
    UIButton * btn = [self addButtonWithName:@"你妹\n走起" withX:margin];
    [btn addTarget:self action:@selector(daoHangZouQi) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * btn1 = [self addButtonWithName:@"弹框\n走起" withX:2 *margin + 66];
    self.button = btn1;
    [btn1 addTarget:self action:@selector(popAgain:) forControlEvents:UIControlEventTouchUpInside];
}

-(UIButton *)addButtonWithName:(NSString *)title withX:(NSInteger)X
{
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(X, 180, 66, 66)];
    [self.view addSubview:btn];
//    btn.center = self.view.center;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.lineBreakMode = 0;
    btn.layer.cornerRadius = 33;
    btn.clipsToBounds = YES;
    [btn setBackgroundColor:[UIColor purpleColor]];
    
    return btn;
    
}


-(void)daoHangZouQi
{
    [self doNavigationWithEndLocation:@[@"26.08",@"119.28"]];
    
}
-(void)doNavigationWithEndLocation:(NSArray *)endLocation
{
    NSMutableArray * maps = [NSMutableArray array];
    // 苹果原生地图和其他第三方地图不一样
    NSMutableDictionary * iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"我擦擦";
    [maps addObject:iosMapDic];
    
    // 百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary * baiDuMapDic = [NSMutableDictionary dictionary];
        baiDuMapDic[@"title"] = @"百度地图";
        baiDuMapDic[@"url"] = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%@,%@|name=北京&mode=driving&coord_type=gcj02",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [maps addObject:baiDuMapDic];
    }
    
    // 高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary * GaoDeMapDic = [NSMutableDictionary dictionary];
        GaoDeMapDic[@"title"] = @"高德地图";
        GaoDeMapDic[@"url"] = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%@&lon=%@&dev=0&style=2",@"导航功能",@"nav123456",endLocation[0],endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [maps addObject:GaoDeMapDic];
    }
    
    
    // 腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary * qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        qqMapDic[@"url"] = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%@,%@&to=终点&coord_type=1&policy=0",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [maps addObject:qqMapDic];
    }
    
    // 谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary * googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        googleMapDic[@"url"] = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%@,%@&directionsmode=driving",@"导航",@"nav123456",endLocation[0], endLocation[1]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [maps addObject:googleMapDic];
    }
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i=0; i<maps.count; i++) {
    
        NSString * title = maps[i][@"title"];
        
        // 苹果地图比较个性
        if (i == 0) {
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:title style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self navAppleMapWithEndLocation:endLocation];
            }];
            [alertVC addAction:action];
            
            continue;
        }
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *urlString = maps[i][@"url"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        
        [alertVC addAction:action];
        
        
    }
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:cancleAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

//苹果地图
- (void)navAppleMapWithEndLocation:(NSArray *)locations
{
    
    NSArray * items;
    
    // 终点坐标
    CGFloat lon = [locations[0] floatValue];
    CGFloat lat = [locations[1] floatValue];
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(lon, lat);
    
    //用户位置
    MKMapItem * currentLoc = [MKMapItem mapItemForCurrentLocation];
    // 终点位置
    if (@available(iOS 10.0, *)) {
        MKPlacemark * placeMark = [[MKPlacemark alloc] initWithCoordinate:loc];
        MKMapItem * endLoc = [[MKMapItem alloc] initWithPlacemark:placeMark];
        
        items = @[currentLoc ,endLoc];
    } else {
        // Fallback on earlier versions
    }
    
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}

#pragma mark - popAgain
-(void)popAgain:(UIButton *)button
{
    popViewController * popVC = [[popViewController alloc] init];
    popVC.preferredContentSize = CGSizeMake(300, 200);
    popVC.modalPresentationStyle = UIModalPresentationPopover;
    
    // 获取控制器的UIPopoverPresentationController
    UIPopoverPresentationController * popover = [popVC popoverPresentationController];
    popover.delegate = self;
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp; // 箭头位置
    popover.sourceView = self.button; // 设置目标视图
    popover.sourceRect = self.button.bounds; // 弹出视图的显示位置
    popover.backgroundColor = [UIColor whiteColor]; // 弹窗背景色
    [self presentViewController:popVC animated:YES completion:nil];
}
#pragma mark - UIPopoverPresentationController 代理
-(BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    return YES; //点击浮窗背景popover controller是否消失
}
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    // 浮窗消失时调用
    NSLog(@"消失后打印信息");
    
}
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    //默认返回的是覆盖整个屏幕，需设置成UIModalPresentationNone。
    return UIModalPresentationNone;
}
@end
