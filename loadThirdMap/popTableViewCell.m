//
//  popTableViewCell.m
//  loadThirdMap
//
//  Created by Cnw on 2018/3/16.
//  Copyright © 2018年 Cnw. All rights reserved.
//

#import "popTableViewCell.h"

@implementation popTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addView];
    }
    
    return self;
    
}

-(void)addView
{
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.image.layer.cornerRadius = 25;
    self.image.clipsToBounds = YES;
    [self.contentView addSubview:self.image];
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.image.frame), 0, self.contentView.frame.size.width - self.image.frame.size.width, 44)];
    [self.contentView addSubview:self.title];
//    self.title.backgroundColor = [UIColor redColor];
    self.title.font = [UIFont systemFontOfSize:15];
    self.title.textAlignment = NSTextAlignmentCenter;
    
    
    
}
-(void)setPopModel:(popModel *)popModel
{
    _popModel = popModel;
    
    self.title.text = popModel.title;
    self.image.image = [UIImage imageNamed:popModel.image];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
