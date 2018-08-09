//
//  popTableViewCell.h
//  loadThirdMap
//
//  Created by Cnw on 2018/3/16.
//  Copyright © 2018年 Cnw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "popModel.h"
@interface popTableViewCell : UITableViewCell
/** 标题 */
@property(nonatomic ,strong)UILabel *title;
/** 图片 */
@property(nonatomic ,strong)UIImageView *image;
/** 模型 */
@property(nonatomic ,strong)popModel *popModel;
@end
