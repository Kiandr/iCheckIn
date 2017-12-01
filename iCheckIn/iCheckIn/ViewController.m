//
//  ViewController.m
//  iCheckIn
//
//  Created by Kian Davoudi-Rad on 2017-10-02.
//  Copyright © 2017 Kian. All rights reserved.
//

#import "ViewController.h"
#include "Common.h"
@import GooglePlaces;
@import GoogleMaps;
@interface ViewController ()

@property (strong, nonatomic)GoogleLogInView * loginView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _loginView= [[GoogleLogInView alloc]initWithMainController:self andDelegateMethod:nil];
    //[self.view addSubview:_loginView.getLoginUIView];
    [self.view bringSubviewToFront:_loginView.getLoginUIView];
    [self.view insertSubview:_loginView.getLoginUIView atIndex:1];
    
    
    /*
    UIView *test = [[UIView alloc] initWithFrame:self.view.frame];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
     GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.myLocationEnabled = YES;
//    self.view = mapView;
    test = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    [self.view addSubview:test];
    */
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
