//
//  ZLPhotoPickerGroupViewController.h
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPhotoPickerViewController.h"

@interface ZLPhotoPickerGroupViewController : UIViewController

@property (nonatomic , weak) id<ZLPhotoPickerViewControllerDelegate> delegate;
@property (nonatomic , assign) PickerViewShowStatus status;
@property (nonatomic , assign) NSInteger minCount;
// 记录选中的值
@property (strong,nonatomic) NSArray *selectAsstes;

@end