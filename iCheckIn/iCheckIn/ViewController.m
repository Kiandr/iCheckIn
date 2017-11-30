//
//  ViewController.m
//  iCheckIn
//
//  Created by Kian Davoudi-Rad on 2017-10-02.
//  Copyright © 2017 Kian. All rights reserved.
//

#import "ViewController.h"
#include "Common.h"
@interface ViewController ()

@property (strong, nonatomic)GoogleLogInView * loginView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //_commonServices =[[Common alloc] init];
    _loginView= [[GoogleLogInView alloc]initWithMainController:self andDelegateMethod:nil];
    [self.view addSubview:_loginView.getLoginUIView];
    [self.view bringSubviewToFront:_loginView.getLoginUIView];
//    [self.view insertSubview:login.getLoginUIView atIndex:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)callBackFunctioniForGetStartedNew:(NSObject *)returnedPointer{
//    
//    NSLog(@"Test");
//}
//

@end
