//
//  OrderListViewController.m
//  mltshop
//
//  Created by mactive.meng on 13/1/15.
//  Copyright (c) 2015 manluotuo. All rights reserved.
//

#import "OrderListViewController.h"
#import "AppRequestManager.h"
#import "SGActionView.h"
#import "UIViewController+ImageBackButton.h"
#import "KKFlatButton.h"

@interface OrderListViewController ()<UITableViewDataSource, UITableViewDelegate, PullListViewDelegate, PassValueDelegate>

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UIView *footerView;
@property(nonatomic, strong)KKFlatButton *flowButton;

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = T(@"购物车");
    self.commonListDelegate = self;
    self.dataSourceType = ListDataSourceOrder;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.y = IOS7_CONTENT_OFFSET_Y;
    self.tableView.height = TOTAL_HEIGHT - IOS7_CONTENT_OFFSET_Y;
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    [self initDataSource];
    //    [self setUpImageDownButton:0];
}

- (void)setUpDownButton:(NSInteger)position
{
    [self setUpImageDownButton:0];
}

- (void)initDataSource
{
    [super initDataSource];
}


- (void)passSignalValue:(NSString *)value andData:(id)data
{
    
}
/**
 *  初始化文章 two goods one line
 */
- (void)setupDataSource {
    self.start = 0;
    self.dataArray = [[NSMutableArray alloc]init];
    [[AppRequestManager sharedManager]operateOrderWithCartModel:nil operation:CartOpsList andBlock:^(id responseObject, NSError *error) {
        
        if (responseObject != nil) {
            // 集中处理所有的数据
            
            NSUInteger count = [responseObject count];
            if (ArrayHasValue(responseObject)) {
                for (int i = 0 ; i < count; i++) {
                    OrderModel *oneOrder = [[OrderModel alloc]initWithDict:responseObject[i]];
                    [self.dataArray addObject:oneOrder];
                }
                NSLog(@"Online setupDataSource ======== ");
                [self showSetupDataSource:self.dataArray andError:nil];
                self.start = self.start + 1;
                NSLog(@"start %ld",(long)self.start);
            }else{
                [DataTrans showWariningTitle:T(@"你还没有订单")
                               andCheatsheet:[NSString fontAwesomeIconStringForEnum:FAInfoCircle]
                                 andDuration:1.0f];
                [self showSetupDataSource:self.dataArray andError:nil];
            }
            
        }
        if (error != nil) {
            [DataTrans showWariningTitle:T(@"获取地址列表有误") andCheatsheet:ICON_TIMES andDuration:1.5f];
        }
        
    }];
}

- (void)recomendNewItems
{
    [self setupDataSource];
}

- (void)recomendOldItems
{
    //    [self setupDataSource];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
