//
//  BonusListTableViewCell.m
//  mltshop
//
//  Created by 小新 on 15/3/16.
//  Copyright (c) 2015年 manluotuo. All rights reserved.
//

#import "BonusListTableViewCell.h"
#import "BonusListModel.h"

@interface BonusListTableViewCell()

/** 红包名称 */
@property (nonatomic, strong) UILabel *bonus_name;
/** 开始时间 */
@property (nonatomic, strong) UILabel *startTime;
/** 红包截止时间 */
@property (nonatomic, strong) UILabel *endTime;
/** 红包金额 */
@property (nonatomic, strong) UILabel *bonusMoney;
/** 红包使用限制金额 */
@property (nonatomic, strong) UILabel *bonusMoneyOrder;

@property (nonatomic, strong) BonusInfoModel *data;

@end

@implementation BonusListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initCellView];
    }
    return self;
}
/** 初始化控件 */
- (void)initCellView {
    
    self.bonus_name = [[UILabel alloc] initWithFrame:CGRectMake(H_15, H_10, WIDTH-H_10*2, H_15)];
    self.bonus_name.font = FONT_16;
    [self addSubview:self.bonus_name];
    self.bonusMoney = [[UILabel alloc] initWithFrame:CGRectMake(H_15, self.bonus_name.y+self.bonus_name.height+H_10, self.bonus_name.width, H_13)];
    self.bonusMoney.font = FONT_14;
    self.bonusMoney.textColor = GREENCOLOR;
    [self addSubview:self.bonusMoney];
    
    self.startTime = [[UILabel alloc] initWithFrame:CGRectMake(H_15, self.bonusMoney.y+self.bonusMoney.height+H_10, WIDTH-H_10*2, H_13)];
    self.startTime.font = FONT_14;
    self.startTime.textColor = [UIColor grayColor];
    [self addSubview:self.startTime];
    
    self.endTime = [[UILabel alloc] initWithFrame:CGRectMake(H_15, self.startTime.y+self.startTime.height+H_10, WIDTH-H_10*2, H_13)];
    self.endTime.font = FONT_14;
    self.endTime.textColor = [UIColor grayColor];
    [self addSubview:self.endTime];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(H_10, 100, WIDTH-H_10*2, 1)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.3;
    [self addSubview:line];
}

- (void)setNewData:(BonusInfoModel *)model {
    

    self.data = model;
    self.bonus_name.text = [NSString stringWithFormat:@"红包名称：%@", self.data.type_name];
    self.bonusMoney.text = [NSString stringWithFormat:@"红包金额：%@元(满%@元可以使用)", self.data.type_money, self.data.min_goods_amount];
    self.startTime.text = [NSString stringWithFormat:@"领取日期：%@", [self setTimer:self.data.send_start_date]];
    self.endTime.text = [NSString stringWithFormat:@"截止日期：%@", [self setTimer:self.data.use_end_date]];
}

- (NSString *)setTimer:(NSString *)time {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time integerValue]+8*3600];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

- (void)awakeFromNib {

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
