//
//  AppRequestManager.h
//  bitmedia
//
//  Created by meng qian on 13-12-25.
//  Copyright (c) 2013年 thinktube. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>

#define API_SIGNIN_PATH             @"/ecmobile/?url=/user/signin"
#define API_SIGNUP_PATH             @"/ecmobile/?url=/user/signup"
#define API_SEARCH_PATH             @"/ecmobile/?url=search"
#define API_CATEGORY_ALL            @"/ecmobile/?url=/home/category"
#define API_HOME_DATA_PATH          @"/ecmobile/?url=/home/data"
#define API_GOODS_DETAILS_PATH      @"/ecmobile/?url=/goods"
#define API_REGION_PATH             @"/ecmobile/?url=/region"
#define API_BRAND_PATH              @"/ecmobile/?url=/brand"
/** 收藏列表 */
#define API_COLLECT_PATH            @"/ecmobile/?url=/user/collect/list"
/** 添加收藏 */
#define API_COLLECT_ADD             @"/ecmobile/?url=/user/collect/create"
/** 删除收藏 */
#define API_COLLECT_DELETE          @"/ecmobile/?url=/user/collect/delete"
/** 订单详情 */
#define API_ORDER_INFO              @"/ecmobile/?url=/order/info"
/** 红包列表 */
#define API_BONUS_LIST              @"/ecmobile/?url=/user/bonus"
/** 评论列表 */
#define API_COMMENT_PATH            @"/ecmobile/?url=/comments/list"
/** 增加评论 */
#define API_COMMENT_ADD             @"/ecmobile/?url=/comment/add"
/** 限时特价 */

/** 获取用户信息 */
#define API_USER_INFO               @"/home/user/info"
/** 更改用户昵称 */
#define API_CHANGE_NICK_NAME        @" /home/user/changeNickName"
/** 更改用户的头像 */
#define API_CHANGE_ICON             @"/home/user/changeHeaderPicture"


#define API_ADDRESS_LIST_PATH       @"/ecmobile/?url=/address/list"
#define API_ADDRESS_CREATE_PATH     @"/ecmobile/?url=/address/add"
#define API_ADDRESS_UPDATE_PATH     @"/ecmobile/?url=/address/update"
#define API_ADDRESS_GET_PATH        @"/ecmobile/?url=/address/info"
#define API_ADDRESS_DELETE_PATH     @"/ecmobile/?url=/address/delete"
#define API_ADDRESS_DEFAULT_PATH    @"/ecmobile/?url=/address/setDefault"

#define API_CART_LIST_PATH          @"/ecmobile/?url=/cart/list"
#define API_CART_CREATE_PATH        @"/ecmobile/?url=/cart/create"
#define API_CART_UPDATE_PATH        @"/ecmobile/?url=/cart/update"
#define API_CART_DELETE_PATH        @"/ecmobile/?url=/cart/delete"

#define API_FLOW_CHECKORDER_PATH    @"/ecmobile/?url=/flow/checkOrder"
#define API_FLOW_DONE_PATH          @"/ecmobile/?url=/flow/done"
#define API_VALIDATE_BONUS_PATH     @"/ecmobile/?url=/validate/bonus"

#define API_ORDER_LIST_PATH         @"/ecmobile/?url=/order/list"
#define API_ORDER_CANCEL_PATH       @"/ecmobile/?url=/order/cancel"
#define API_ORDER_PAY_PATH          @"/ecmobile/?url=/order/pay"
#define API_ORDER_AFFIRM_RECEIVED_PATH  @"/ecmobile/?url=/order/affirmReceived"


#define API_UPLOAD_PICTURE          @"/upload/picture"
#define API_CREATE_VEHICLE_GALLERY  @"/gallery/create"
#define API_UPDATE_VEHICLE_GALLERY  @"/gallery/update"

#define API_CREATE_VEHICLE          @"/vehicle/create"
#define API_LIST_VEHICLE            @"/vehicle/list"
#define API_UPDATE_VEHICLE          @"/vehicle/update"
#define API_DELETE_VEHICLE          @"/vehicle/delete"
#define API_CHECK_VEHICLE_VIN       @"/vehicle/spec/list_by_vin"
#define API_GET_VEHICLE             @"/vehicle/get"
#define API_CREATE_SHARE_VEHICLE    @"/vehicle/create_share"
#define API_CREATE_ADJUST_PRICE     @"/vehicle/adjust_price"
#define API_CREATE_SUBSTITUTE_VEHICLE  @"/vehicle/create_substitute"
#define API_OFFLINE_VEHICLE         @"/vehicle/offline"

#define API_CREATE_SHARE_ACCOUNT    @"/share/account/create"
#define API_GET_SHARE_ACCOUNT       @"/share/account/get"
#define API_DELETE_SHARE_ACCOUNT    @"/share/account/delete"
#define API_LIST_SHARE_ACCOUNT      @"/share/account/list"
#define API_UPDATE_SHARE_ACCOUNT    @"/share/account/update"
#define API_GET_SHARE_AVAILABILITY  @"/share/availability/get"

#define API_USER_GET_PATH           @"/ecmobile/?url=/user/info"
#define API_USER_UPDATE_PATH        @"/user/update"
#define API_USER_EXIST              @"/user/check"
#define API_USER_SUMMARY            @"/user/summary"
#define API_UPDATE_PASSWORD         @"/user/change_password"
#define API_FORGOT_PASSWORD         @"/user/forgot_password"
#define API_RESET_PASSWORD          @"/user/reset_password"
#define API_VERIFICATION_SENDSMS    @"/verification_code/create"
#define API_VERIFICATION_CHECKSMS   @"/verification_code/check"
#define API_AREA_SELECT_MARKET      @"/area/select_market"

#define API_ES_SEARCH               @"/es/vehicle/search"

#define API_SUBSTITUTE_USER_GET     @"/substitute/user/get"

#define API_MERCHANT_SHARE          @"/share/job/send"
#define API_HISTORY_LIST            @"/share/job/search"
#define API_HISTORY_LOG_LIST        @"/share/job/history/list"

#define API_AD_COVER_PATH           @"/ad/cover"
#define API_UPLOAD_LOCATION_PATH    @"/location/upload"

#define API_GET_THIRD_MODELID       @"/external_vehicle/spec/select"
#define API_HISTORY_SHARE_RESTART   @"/share/job/restart"

#define API_CONTACTS_LIST           @"/crm/contacts/list"
#define API_CONTACTS_GET            @"/crm/contacts/get"
#define API_CONTACTS_SEARCH         @"/crm/contacts/search"

#define API_FAVORITE_CREATE         @"/favourite/create"
#define API_FAVORITE_LIST           @"/favourite/list"
#define API_FAVORITE_CHECK          @"/favourite/check"
#define API_FAVORITE_DELETE         @"/favourite/delete"

#define API_PUSH_BIND               @"/push/bind"
#define API_NOTIFICATION_LIST       @"/notification/list"

@interface AppRequestManager : AFHTTPSessionManager

@property (nonatomic)NSNumber * kNetworkStatus;
@property (nonatomic)BOOL isLoggedIn;
@property (strong, nonatomic)NSString * appNetworkAPIBaseURLString;

+ (AppRequestManager *)sharedManager;
+ (AppRequestManager *)sharedWeiboManager;
+ (void) updateSharedInstance;

/** API/Comment */
- (void)getCommentWithGoodsId:(NSString *)goodsId andBlock:(void (^)(id responseObject, NSError *error))block;

//  API/System
- (void)getSystemNotificationWithBlock:(void (^)(id responseObject, NSError *error))block;

//  API/sign_in
- (void)signInWithUsername:(NSString *)username password:(NSString *)password andBlock:(void (^)(id responseObject, NSError *error))block;


// API/sign_up
- (void)signUpWithMobile:(NSString *)mobile password:(NSString *)password email:(NSString *)email andBlock:(void (^)(id responseObject, NSError *error))block;

// API/brand
- (void)getBrandAllWithBlock:(void (^)(id responseObject, NSError *error))block;

// API/category
- (void)getCategoryAllWithBlock:(void (^)(id responseObject, NSError *error))block;

// API/Goods
- (void)getGoodsDetailWithGoodsId:(NSString *)goodsId andBlcok:(void (^)(id responseObject, NSError *error))block;

// API/search
- (void)searchWithKeywords:(NSString *)keywords
                    cateId:(NSString *)cateId
                   brandId:(NSString *)brandId
                     intro:(NSString *)intro
                      page:(NSInteger)page
                      size:(NSInteger)size
                  andBlock:(void (^)(id responseObject, NSError *error))block;

// API/home/data
- (void)getHomeDataWithBlock:(void (^)(id responseObject, NSError *error))block;


// ADDRESS Functions
- (void)getAddressListWithBlock:(void (^)(id responseObject, NSError *error))block;
- (void)operateAddressWithAddress:(AddressModel *)theAddress
                        operation:(NSUInteger)operation
                        andBlock:(void (^)(id responseObject, NSError *error))block;

// CART function
- (void)operateCartWithCartModel:(CartModel *)theCart
                     operation:(NSUInteger)operation
                      andBlock:(void (^)(id responseObject, NSError *error))block;
/** 我的收藏 */
- (void)getCollectListWithBlock:(void (^)(id responseObject, NSError *error))block;
/** 删除收藏 */
- (void)getDeleteCollectRecId:(NSString *)recId andBlcok:(void (^)(id responseObject, NSError *error))block;
/** 收藏 */
- (void)getCollectAddWithGoodsId:(NSString *)goodsId andBlock:(void (^)(id responseObject, NSError *error))block;

/** 订单详情 */
- (void)getOrderDetailOrderId:(NSString *)orderId andBlock:(void (^)(id responseObject, NSError *error))block;
/** 红包列表 */
- (void)getBonusListWithBlock:(void (^)(id responseObject, NSError *error))block;

/** 新增评论 */
- (void)getCommentAddWithDict:(NSDictionary *)dict andBlock:(void (^)(id responseObject, NSError *error))block;
/** 限时特价 */
- (void)setLimitDataBlock:(void (^)(id responseObject, NSError *error))block;


// ORDER function
- (void)operateOrderWithOrderModel:(OrderModel *)theOrder
                         operation:(NSUInteger)operation andPage:(NSInteger)page
                         andBlock:(void (^)(id responseObject, NSError *error))block;


// API/REGION
- (void)getAreaWithParentID:(NSString *)parentId andBlock:(void (^)(id responseObject, NSError *error))block;

// flow checkOrder
- (void)flowCheckOrderWithBlock:(void (^)(id responseObject, NSError *error))block;

// flow done
- (void)flowDoneWithFlowDoneModel:(FlowDoneModel *)flowModel andBlock:(void (^)(id responseObject, NSError *error))block;




// API/merchant/user/me
- (void)getMerchantMeWithToken:(NSString *)token andBlock:(void (^)(id responseObject, NSError *error))block;

// API/upload/picture
- (void)uploadPicture:(NSURL *)url resize:(CGSize)resize andBlock:(void (^)(id responseObject, NSError *error))block;

// API/merchant/vehicle/gallery/update
- (void)updateVehicleGalleryWithDict:(NSMutableDictionary *)dict andBlock:(void (^)(id responseObject, NSError *error))block;

// API/merchant/vehicle/gallery/create
- (void)createVehicleGalleryWithDict:(NSMutableDictionary *)dict andBlock:(void (^)(id responseObject, NSError *error))block;

// API/merchant/vehicle/create
- (void)createVehicleWithDict:(NSMutableDictionary *)dict andBlock:(void (^)(id responseObject, NSError *error))block;

// API/merchant/vehicle/update
- (void)updateVehicleWithDict:(NSMutableDictionary *)dict andBlock:(void (^)(id responseObject, NSError *error))block;



// API/merchant/vehicle/delete
- (void)deleteVehicleWithVehicleId:(NSString *)vehicleId
                          andBlock:(void (^)(id responseObject, NSError *error))block;


// API/merchant/vehicle/list
- (void)listVehicleWithMerchantId:(NSString *)merchantId
                      substituted:(BOOL)substituted
                          andPage:(NSInteger)page
                          andSize:(NSInteger)size
                        andStatus:(NSString *)cloudStatus
                         andBlock:(void (^)(id responseObject, NSError *error))block;

// API/vehicle/spec/list_by_vin"
- (void)checkVehicleVin:(NSString *)vinCode andBlock:(void (^)(id responseObject, NSError *error))block;


// API/merchant/share
- (void)sendShareWithDict:(NSDictionary *)dict andBlock:(void (^)(id responseObject, NSError *error))block;


// API "/user/exist"
-(void)userExistWithInviteMobile:(NSString *)inviteMobile andBlock:(void (^)(id responseObject, NSError *error))block;

// API "/user/change_password"
-(void)updatePasswordWithUserId:(NSString *)userId
                    oldPassowrd:(NSString *)oldPassword
                       password:(NSString *)password
                       andBlock:(void (^)(id responseObject, NSError *error))block;

// API "/user/forgot_password"
-(void)forgotPasswordWithMyMobile:(NSString *)myMobile andBlock:(void (^)(id responseObject, NSError *error))block;

// API "/user/forgot_password"
-(void)resetPasswordWithMyMobile:(NSString *)myMobile code:(NSString *)code passowrd:(NSString *)password andBlock:(void (^)(id responseObject, NSError *error))block;

// verification/sendSMS
- (void)sendSMSWithInviteMobile:(NSString *)inviteMobile andMobile:(NSString *)mobile andBlock:(void (^)(id responseObject, NSError *error))block;

// verification/checkSMS
- (void)checkSMSWithMobile:(NSString *)mobile andCode:(NSString *)code andBlock:(void (^)(id responseObject, NSError *error))block;

// API/user/get
- (void)getUserInfoWithUserId:(NSString *)userId andBlock:(void (^)(id responseObject, NSError *error))block;

// API/substitute/user
- (void)getSubstituteUserWithUserId:(NSString *)userId andBlock:(void (^)(id responseObject, NSError *error))block;

// API/user/update
- (void)updateUserInfoWithData:(NSDictionary *)userData andBlock:(void (^)(id responseObject, NSError *error))block;


// API /history/list
- (void)listHistoryWithSite:(NSString *)site
                  vehicleId:(NSString *)vehicleId
                  andStatus:(NSString *)status
                    andPage:(NSInteger)page
                    andSize:(NSInteger)size
                   andBlock:(void (^)(id responseObject, NSError *error))block;
// API /share/availability/get
- (void)getAvailabilitySiteWithBlock:(void (^)(id responseObject, NSError *error))block;


// API /history/list
- (void)listHistoryLogWithHistoryId:(NSString *)historyId
                            andPage:(NSInteger)page
                            andSize:(NSInteger)size
                           andBlock:(void (^)(id responseObject, NSError *error))block;

#pragma mark 选择第三方车型后重新发车
- (void)shareHistoryRestartWithShareJobId:(NSString *)shareJobId
                andExternalVehicleModelId:(NSString *)modelId
                                 andBlock:(void (^)(id responseObject, NSError *error))block;

#pragma mark 获得vehicle
- (void)getVehicleWithVehicleId:(NSString *)vehicleId
                       andBlock:(void (^)(id responseObject, NSError *error))block;

#pragma mark 看车网车源搜索
// API/es/vehicle/search
- (void)getSearchVehicleWithDict:(NSMutableDictionary *)searchDict
                    andOrderDict:(NSMutableDictionary *)orderDict
                         andPage:(NSInteger)page
                         andSize:(NSInteger)size
                        andBlock:(void (^)(id responseObject, NSError *error))block;

#pragma mark 上传并分发车源
- (void)createAndShareVehicle:(NSMutableDictionary *)dict andShareAccountList:(NSArray *)shareAccountList andBlock:(void (^)(id responseObject, NSError *error))block;
- (void)createSubstituteVehicleWithDict:(NSMutableDictionary *)dict andBlock:(void (^)(id responseObject, NSError *error))block;


#pragma mark 客户管理
- (void)getContactsListWithUserId:(NSString *)userId
                          andPage:(NSInteger)page
                          andSize:(NSInteger)size
                         andBlock:(void (^)(id responseObject, NSError *error))block;

- (void)getOneContactWithUserId:(NSString *)userId
                     customerId:(NSString*)customerId
                       andBlock:(void (^)(id responseObject, NSError *error))block;

- (void)searchContactWithUserId:(NSString *)userId
                   searchString:(NSString *)searchString
                        andPage:(NSInteger)page
                        andSize:(NSInteger)size
                       andBlock:(void (^)(id responseObject, NSError *error))block;
#pragma mark 修改价格
// API/vehicle/adjust_price
- (void)updatePriceWithVehicleId:(NSString *)vehicleId
               andNewQuotedPrice:(NSNumber *)newQuotedPrice
                        andBlock:(void (^)(id responseObject, NSError *error))block;
#pragma mark 车辆下架与停止代运营
//API/vehicle/offline
- (void)offlineVehicleWithVehicleId:(NSString *)vehicleId
                        andBidPrice:(NSNumber *)bidPrice
                      andOfferPrice:(NSNumber *)offerPrice
                           andBlock:(void (^)(id responseObject, NSError *error))block;

#pragma mark bind deviceToken
- (void)pushBindWidthDevice:(NSString *)device
             andDeviceToken:(NSString *)deviceToken
                   andBlock:(void (^)(id responseObject, NSError *error))block;

#pragma mark 收藏
- (void)createFavoriteWithResourceType:(NSString *)resourceType
                         andResourceId:(NSString *)resourceId
                              andBlock:(void (^)(id responseObject, NSError *error))block;

- (void)getFavoriteListWithUserId:(NSString *)userId
                          andPage:(NSInteger)page
                          andSize:(NSInteger)size
                         andBlock:(void (^)(id responseObject, NSError *error))block;

- (void)checkFavoriteIsExistedWithResourceType:(NSString *)resourceType
                                 andResourceId:(NSString *)resourceId
                                      andBlock:(void (^)(id responseObject, NSError *error))block;

- (void)deleteFavoriteWithResourceType:(NSString *)resourceType
                         andResourceId:(NSString *)resourceId
                              andBlock:(void (^)(id responseObject, NSError *error))block;

#pragma mark 获取推送消息列表
- (void)getMessageListWithUserId:(NSString *)userId
                         andPage:(NSInteger)page
                         andSize:(NSInteger)size
                        andBlock:(void (^)(id responseObject, NSError *error))block;

#pragma mark 获取商家地区选择
- (void)getUserCompanyAddressWithCityCode:(NSString *)cityCode
                                 andBlock:(void (^)(id responseObject, NSError *error))block;


@end

