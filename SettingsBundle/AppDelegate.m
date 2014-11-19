//
//  AppDelegate.m
//  SettingsBundle
//
//  Created by syweic on 14/11/18.
//  Copyright (c) 2014年 ___iSoftStone___. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(void)getSettingBundle
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    
    NSString *filePath = [path stringByAppendingPathComponent:@"Root.plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    
    NSArray *array = dict[@"PreferenceSpecifiers"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *mySetting = [[NSMutableDictionary alloc] init];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = obj;
        
        NSString *key = dic[@"Key"];
        if ([self checkKeyWith:key]) {
            if (dic[@"DefaultValue"]) {
                NSLog(@"key = %@,value = %@",key,dic[@"DefaultValue"]);
                [mySetting setObject:dic[@"DefaultValue"] forKey:key];
            }
        }
        
        
    }];
    [userDefaults registerDefaults:mySetting];
    [userDefaults synchronize];
    
}

-(BOOL)checkKeyWith:(NSString*)key
{
    if ([key isEqualToString:@"name"] || [key isEqualToString:@"messages"] || [key isEqualToString:@"floatValue"] || [key isEqualToString:@"uLike"]) {
        return YES;
    }
    return NO;
}

// 检测Settings.bundle对应的key在NSUserDefaults中是否有值
-(BOOL)checkAllValue{
    __block BOOL bol = YES;
    NSArray *keys = @[@"name",@"messages",@"floatValue",@"uLike"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![userDefaults objectForKey:obj]) {
            bol = NO;
            *stop = YES;
        }
    }];
    return bol;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
     * 在对Settings.bundle 进行第一次操作前(操作包括所有的设置)
     * NSUserDefaults中是读不出数据的
     * 若想从NSUserDefaults读出Settings.bundle中的数据，至少对Settings.bundle进行一次
     * 或者添加以下代码，从Settings.bundle中读出数据保存到NSUserDefaults
     */
    if (![self checkAllValue]) {
        // 没有值 ,读取Settings.bundle中的默认值
        // 因此 在设置Settings.bundle时，最好都设置DefaultValue
        [self getSettingBundle];
    }
    
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

@end
