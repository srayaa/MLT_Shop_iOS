//
//  AddressInfoViewController.h
//  mltshop
//
//  Created by mactive.meng on 21/12/14.
//  Copyright (c) 2014 manluotuo. All rights reserved.
//

#import "MMViewController.h"

@interface AddressInfoViewController : MMViewController

@property (nonatomic, weak) id<PassValueDelegate> passDelegate;

- (void)setNewData:(AddressModel *)address;

@end
