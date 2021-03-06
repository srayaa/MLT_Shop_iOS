//
//  AppDelegate.m
//  mltshop
//
//  Created by mactive.meng on 12/11/14.
//  Copyright (c) 2014 manluotuo. All rights reserved.
//

#import "AppDelegate.h"
#import "ColorNavigationController.h"
#import "MMNavigationController.h"
#import <MMDrawerController/MMDrawerController.h>
#import <MMDrawerController/MMDrawerVisualState.h>
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "AppRequestManager.h"
#import "KKDrawerViewController.h"
#import "ModelHelper.h"
#import "ProfileViewController.h"
#import <AlipaySDK/AlipaySDK.h>

#import "FirstHelpViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"

#import "ShareHelper.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <SDWebImage/SDImageCache.h>

#import "JPushViewController.h"

#import "Reachability.h"

//#import "HYBJPushHelper.h"
#import "APService.h"

#define MR_LOGGING_ENABLED 0
@interface AppDelegate ()
@property(nonatomic, strong)KKDrawerViewController * drawerController;
@property (strong, nonatomic)RightMenuViewController *rightSideDrawerViewController;
@property(nonatomic, strong)LoginViewController *loginViewController;
@property(nonatomic, strong)RegisterViewController *registerViewController;
@property(nonatomic, strong)FirstHelpViewController *firstHelpViewController;
@property (nonatomic, strong) Reachability *reachabilityManager;

@property(nonatomic, strong)NSString *versonUrl;

@end

@implementation AppDelegate {
    HTProgressHUD *HUD;
}
@synthesize drawerController;
@synthesize firstHelpViewController;
@synthesize loginViewController;
@synthesize registerViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
#warning 0511 -  现有的Bug 当网络发生改变时, 已登录的用户会丢失链接, 导致获取不到商品详情数据
    //监测网络情况, 网络改变后重新登录
    _reachabilityManager = [Reachability reachabilityWithHostName:@"baidu.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkStatus) name:kReachabilityChangedNotification object:nil];
    // 启动监听
    [self.reachabilityManager startNotifier];
    
    
    
    //     Override point for customization after application launch.
    //    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:BATCH channelId:nil];
    //    NSString *nowVersion = NOWVERSION;
    //    NSString *nowBuild = NOWBUILD;
    //    [MobClick setAppVersion:[NSString stringWithFormat:@"V_%@#%@",nowVersion,nowBuild]];
    
    //    [HYBJPushHelper setupWithOptions:launchOptions];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:@"NO" forKey:@"HELLO"];
    [user synchronize];
    
    /** 设置友盟 */
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:BATCH   channelId:@"nil"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    //TODO: 发布时注释掉这行
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
//     [MobClick setLogEnabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
    [MobClick event:UM_START];
    
    [WXApi registerApp:WXAPI_APP_ID];
    [WeiboSDK registerApp:WEIBO_APP_KEY];
    TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_API_ID andDelegate:self];
    tencentOAuth.redirectURI = @"";
    
    /** 调用极光推送 */
    [self initJPush:launchOptions];
    
    NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
    
    NSString *storeNamed = @"manluotuo.sqlite";
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:storeNamed];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.me = [[ModelHelper sharedHelper]findOnlyMe];
    
    /**
     *  DRAWER ViewController
     */
    UIViewController *leftSideDrawerViewController = [[LeftMenuViewController alloc]init];
    self.centerViewController = [[HostViewController alloc] init];
    self.rightSideDrawerViewController = [[RightMenuViewController alloc]init];
    
    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:self.centerViewController];
    
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    UINavigationController * rightSideNavController = [[MMNavigationController alloc] initWithRootViewController:self.rightSideDrawerViewController];
    [rightSideNavController setRestorationIdentifier:@"MMExampleRightNavigationControllerRestorationKey"];
    UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
    [leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    self.drawerController = [[KKDrawerViewController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:leftSideNavController
                             rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:NO];
    
    // custom drawer style
    
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:MAX_LEFT_DRAWER_WIDTH];
    [self.drawerController setMaximumRightDrawerWidth:MAX_LEFT_DRAWER_WIDTH];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setDrawerVisualStateBlock:[MMDrawerVisualState slideAndScaleVisualStateBlock]];
    
    // 打开侧边栏 关闭侧边栏
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //    [self checkUserLogin];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [[UINavigationBar appearance] setTintColor:WHITECOLOR];
    
    //    if (!OSVersionIsAtLeastiOS7()) {
    //        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    //    }
    
    
    [self skipIntroView];
    
    return YES;
}
/**
 *  监测网络情况
 */
- (void)checkStatus {
    if (XAppDelegate.me.userId) {
        switch (self.reachabilityManager.currentReachabilityStatus) {
            case ReachableViaWiFi:
                [self reLogin];
                break;
            case ReachableViaWWAN:
                [self reLogin];
                break;
            default:
                break;
        }
    }
}

-(void)reLogin{
    [[AppRequestManager sharedManager] signInWithUsername:XAppDelegate.me.username password:XAppDelegate.me.password andBlock:^(id responseObject, NSError *error) {
        //NSLog(@"%@**************",responseObject);
        if (responseObject != nil) {
            [MobClick event:UM_LOGIN];
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
            [[ModelHelper sharedHelper]updateMeWithJsonData:dict];
        }
        if(error != nil) {
            [self reLogin];
        }
    }];

}

/** 极光推送 */
- (void)initJPush:(NSDictionary *)launchOptions {
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kJPFNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kJPFNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kJPFNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kJPFNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    [APService setupWithOption:launchOptions];
#warning 设备标签与别名 - 发布时删除
    [APService setTags:[NSSet setWithObjects:@"800049", nil] alias:@"可宁" callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

- (void)showDrawerView {
    NSLog(@"showMainView");
    
    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:self.centerViewController];
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    HUD = [[HTProgressHUD alloc] init];
    HUD.indicatorView = [HTProgressHUDIndicatorView indicatorViewWithType:HTProgressHUDIndicatorTypeActivityIndicator];
    HUD.text = T(@"正在获取数据~请稍后");
    [HUD showInView:self.window];
    [self getAllCategoryWithBlock:^(BOOL success) {
        if(success){
            [HUD removeFromSuperview];
            [self.drawerController setCenterViewController:navigationController];
            [self.window setRootViewController:self.drawerController];
            [self.window addSubview:self.drawerController.view];
            [self.window makeKeyAndVisible];
        }
    }];
}

- (void)skipIntroView {
    // 用户第一次打开
    NSNumber *result = GET_DEFAULT(@"HELPSEEN_INTRO");
    
    if (!result.boolValue) {
        [self showIntroductionView];
    } else {
        NSLog(@"APP ME  %@",self.me);
        if (!StringHasValue(self.me.userId)) {
            NSLog(@"会记住登录信息,用户还没有登录");
            [self showLoginView];
        }else{
            [self loginWithSavedUserInfo];
            //            NSLog(@"用户已经登录");
            //            [self showDrawerView];
        }
    }
}

// 利用现有的用户名密码登陆
- (void)loginWithSavedUserInfo {
    // 缺一不可
    if (!StringHasValue(self.me.username) ||  !StringHasValue(self.me.password)) {
        [self showLoginView];
        return;
    }
    [self showDrawerView];
    
    /** 获取用户信息 */
    NSString *httpUrl = @"http://sj.manluotuo.com/home/user/info";
    AFHTTPRequestOperationManager *rom=[AFHTTPRequestOperationManager manager];
    rom.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/json",@"text/html", nil];
    NSDictionary *postDict = @{@"userid": [DataTrans
                                           noNullStringObj: XAppDelegate.me.userId]};
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:XAppDelegate.me.userId forKey:@"userid"];
    [user synchronize];
    [rom POST:httpUrl parameters:postDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUD removeFromSuperview];
        if ([responseObject[@"SUCESS"] integerValue] == 1) {
            Me *theMe = [[ModelHelper sharedHelper]findOnlyMe];
            theMe.avatarURL =  responseObject[@"data"][@"headerimg"];
            MRSave();
            XAppDelegate.me = theMe;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUD removeFromSuperview];
        NSLog(@"%@",error);
    }];

    [[AppRequestManager sharedManager] signInWithUsername:self.me.username password:self.me.password andBlock:^(id responseObject, NSError *error) {
        if (responseObject != nil) {
            [MobClick event:UM_LOGIN];
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] initWithDictionary:responseObject];
            [[ModelHelper sharedHelper]updateMeWithJsonData:dict];
            // 显示主页面
        }
        if(error != nil) {
            // 显示登陆页面
            [self showLoginView];
        }
    }];
}

- (void)showIntroductionView
{
    NSLog(@"showIntroductionView");
    self.firstHelpViewController = [[FirstHelpViewController alloc]initWithNibName:nil bundle:nil];
    
    [self.window setRootViewController:self.firstHelpViewController];
    [self.window addSubview:self.firstHelpViewController.view];
    [self.window makeKeyAndVisible];
}

- (void)showRegisterView
{
    NSLog(@"showRegisterView");
    self.registerViewController = [[RegisterViewController alloc]initWithNibName:nil bundle:nil];
    
    [self.window setRootViewController:self.registerViewController];
    [self.window addSubview:self.registerViewController.view];
    [self.window makeKeyAndVisible];
}

- (void)showLoginView
{
    NSLog(@"showRegisterView");
    self.loginViewController = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
    
    [self.window setRootViewController:self.loginViewController];
    [self.window addSubview:self.loginViewController.view];
    [self.window makeKeyAndVisible];
}

- (void)getAllCategoryWithBlock:(void (^)(BOOL success))block
{
    self.allCategory = [[NSMutableArray alloc]init];
    [[AppRequestManager sharedManager]getCategoryAllWithBlock:^(id responseObject, NSError *error) {
        if (responseObject != nil) {
            if (!HUD) {
                [HUD removeFromSuperview];
            }
            for (int i = 0 ; i < [responseObject count]; i++) {
                CategoryModel *model = [[CategoryModel alloc]initWithDict:responseObject[i]];
                [self.allCategory addObject:model];
            }
            block(YES);
        }else{
            if (!HUD) {
                [HUD removeFromSuperview];
            }
            [DataTrans showWariningTitle:T(@"分类获取失败") andCheatsheet:ICON_TIMES];
        }
    }];
}

/** 支付宝 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             //             NSLog(@"result = %@", resultDic);
             // 付款成功查看订单
             if([resultDic[@"resultStatus"] isEqualToString:@"9000"]){
                 [MobClick event:UM_PAY];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:nil userInfo:nil];
             }
             if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                 [MobClick event:UM_PAY_BAD];
             }
             if([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                 [DataTrans showWariningTitle:T(@"您取消了支付") andCheatsheet:ICON_TIMES];
                 
             }
         }];
    }
    
    // url wb668969160://response?id=69B2FF58-682E-408C-83A2-DCAECE8781C3&sdkversion=2.4
    // url wxd930ea5d5a258f4f://platformId=wechat
    // url tencent101019374://qzapp/mqzone/0?generalpastboard=1
    
#if __QQAPI_ENABLE__
    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[ShareHelper sharedHelper]];
#endif
    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    
    if ([[url absoluteString] hasPrefix:WEIBO_APP_ID]) {
        return [WeiboSDK handleOpenURL:url delegate:[ShareHelper sharedHelper]];
    }else if([[url absoluteString]hasPrefix:WXAPI_APP_ID]){
        return [WXApi handleOpenURL:url delegate:[ShareHelper sharedHelper]];
    }
    
    return YES;
}

/** QQ分享 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
#if __QQAPI_ENABLE__
    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[ShareHelper sharedHelper]];
#endif
    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    if([[url absoluteString]hasPrefix:WXAPI_APP_ID]){
        return [WXApi handleOpenURL:url delegate:[ShareHelper sharedHelper]];
    }else if ([[url absoluteString]hasPrefix:WEIBO_APP_ID]){
        return [WeiboSDK handleOpenURL:url delegate:[ShareHelper sharedHelper]];
    }
    return YES;
}

/** 推送 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //    [HYBJPushHelper registerDeviceToken:deviceToken];
    [APService registerDeviceToken:deviceToken];
    
    return;
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    [HYBJPushHelper showLocalNotificationAtFront:notification];
//    return;
//}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    return;
}



#pragma mark - 极光推送通知信息
- (void)networkDidSetup:(NSNotification *)notification {
    
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    
    NSLog(@"已登录");
    
}

/** 获取附加字段 */
- (void)setJPushAvtion:(NSDictionary *)userInfo {
    
    //url 网页地址
    //goods  商品id
    //action 我们自己定
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得自定义字段内容
    NSString *url = [userInfo valueForKey:@"url"]; //自定义参数，key是自己定义的
    NSString *goods = [userInfo valueForKey:@"goods"];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:url forKey:@"url"];
    [user setValue:goods forKey:@"goods"];
    [user synchronize];
    
    NSLog(@"content = [%@], badge = [%d], sound = [%@], goods = [%@], url = [%@]", content,badge,sound, goods, url);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    [self setJPushAvtion:userInfo];
    // Required
    [APService handleRemoteNotification:userInfo];
    
    NSLog(@"%@",userInfo);
    
}

//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:  (NSDictionary *)userInfo fetchCompletionHandler:(void (^)   (UIBackgroundFetchResult))completionHandler {
    // 取得 APNs 标准信息内容
    [self setJPushAvtion:userInfo];
    
    // Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}


/** 自定义消息 */
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *extras = [userInfo valueForKey:@"extras"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"收到消息\ndate:%@\nextras:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],extras,content);
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

@end
