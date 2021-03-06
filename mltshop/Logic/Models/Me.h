//
//  Me.h
//  mltshop
//
//  Created by mactive.meng on 29/11/14.
//  Copyright (c) 2014 manluotuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Me : NSManagedObject

@property (nonatomic, retain) NSString * avatarURL;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * userToken;
@property (nonatomic, retain) NSString * sessionId;
@property (nonatomic, retain) NSString * rankName;
@property (nonatomic, retain) NSNumber * rankLevel;
@property (nonatomic, retain) NSData * orderNum;
@property (nonatomic, retain) NSNumber * collectionNum;

@end
