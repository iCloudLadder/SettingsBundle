//
//  ViewController.m
//  SettingsBundle
//
//  Created by syweic on 14/11/18.
//  Copyright (c) 2014年 ___iSoftStone___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 对Settings.bundle进行读取
    NSLog(@"name = %@",[userDefaults objectForKey:@"name"]);
    NSLog(@"messages = %@",[userDefaults objectForKey:@"messages"]);
    NSLog(@"floatValue = %@",[userDefaults objectForKey:@"floatValue"]);
    NSLog(@"uLike = %@",[userDefaults objectForKey:@"uLike"]);
    
    

    [userDefaults setObject:@"慕容" forKey:@"name"];
    [userDefaults setObject:@"是" forKey:@"messages"];
    [userDefaults setFloat:70.0 forKey:@"floatValue"];
    [userDefaults setObject:@"足球" forKey:@"uLike"];

    //[self getSettingBundle];
}




-(void)getSettingBundle
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    NSLog(@"path = %@",path);
    
    NSString *filePath = [path stringByAppendingPathComponent:@"Root.plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSLog(@"dict  = %@",dict);
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
