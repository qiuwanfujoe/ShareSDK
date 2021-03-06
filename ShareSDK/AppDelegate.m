//
//  AppDelegate.m
//  ShareSDK
//
//  Created by Gideon on 1/28/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "weixinSDK/WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "Constant.h"

@interface AppDelegate () <WeiboSDKDelegate, WXApiDelegate, TencentSessionDelegate>
@property (nonatomic, retain)TencentOAuth *oauth;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaWeiboAppKey];
    
    [WXApi registerApp:kWeixinAppKey];
    
    _oauth = [[TencentOAuth alloc] initWithAppId:kQQAppId
                                     andDelegate:self];
    return YES;
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.scheme isEqualToString:kWeixinAppKey]) {
        return [WXApi handleOpenURL:url delegate:self];
    } else if ([url.scheme isEqualToString:kSinaWeiboAppKey]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    } else if ([url.scheme isEqualToString:kQQSchema]) {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.scheme isEqualToString:kWeixinAppKey]) {
        return [WXApi handleOpenURL:url delegate:self];
    } else if ([url.scheme isEqualToString:kSinaWeiboAppKey]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    } else if ([url.scheme isEqualToString:kQQSchema]) {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{

}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{

}

#pragma mark - 微信
-(void)onReq:(BaseReq*)req
{

}

- (void)onResp:(BaseResp *)resp
{

}

#pragma mark - QQ

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
    
}

@end
