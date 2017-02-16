//
//  ViewController.m
//  AlertBlock
//
//  Created by 薛飞龙 on 2017/2/16.
//  Copyright © 2017年 薛飞龙. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

static void *MyAlertKey = "MyAlertKey";


@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}

- (void)btnClick
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"111111"
                                                     message:@"222222"
                                                    delegate:self
                                           cancelButtonTitle:@"cancel"
                                           otherButtonTitles:@"continue", nil];
    void (^block)(NSInteger) = ^(NSInteger buttonIndex){
        if (buttonIndex == 0) {
            NSLog(@"cancel");
        }else{
            NSLog(@"continue");
        }
        
    };
    objc_setAssociatedObject(alert,
                             MyAlertKey,
                             block,
                             OBJC_ASSOCIATION_COPY);
    
    [alert show];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^block)(NSInteger) = objc_getAssociatedObject(alertView, MyAlertKey);
    block(buttonIndex);

}


@end
