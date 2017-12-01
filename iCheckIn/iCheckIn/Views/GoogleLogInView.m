//
//  AppDelegate.m
//  iCheckIn
//
//  Created by Kian Davoudi-Rad on 2017-10-02.
//  Copyright © 2017 Kian. All rights reserved.
//
@import GoogleMaps;
#import "GoogleLogInView.h"

@interface GoogleLogInView ()


@property (strong, nonatomic) UIView* motherUIView;
@property (strong, nonatomic) UIViewController* motherController;
@property (strong, nonatomic) UITextView* welcomeMessage;
@property (strong, nonatomic) UIButton *getStarted;
@property (strong, nonatomic) UIImageView *backGroundPicture;
@property (strong, nonatomic) UIImageView *logo ;

@property (strong, nonatomic)UITextField *welcomeMessageView;
@property (strong, nonatomic) NSString *welcomeMessageString;

@property (strong, nonatomic)UIView *googleMapView;
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSCameraPosition *camera;
@end

@implementation GoogleLogInView

@synthesize delegate;

- (instancetype)initWithMainController:(UIViewController*)incomingMotherController andDelegateMethod:(id *)commonServices
{
    self = [super init];
    if (self) {
        _motherController = incomingMotherController;
        //[incomingMotherController.view addSubview:_motherUIView];
        delegate = self;
        [self startUpSequence];
    }
    return self;
}

-(void) startUpSequence{
    [self initializeTheMotherUIView];
    
}

-(void)eventButton{
    NSLog(@"clicked");
    
}

-(void) initializeTheMotherUIView{
    
    _motherUIView= [[UIView alloc] initWithFrame:_motherController.view.frame];
    [_motherUIView setBackgroundColor:[UIColor blackColor]];
    _welcomeMessageView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 50, 200)];
    _welcomeMessageString = [[NSString alloc] initWithFormat:@"Welcome To Nurse Next Door"];
    [_welcomeMessageView setText:_welcomeMessageString];
    [_welcomeMessageView  setFrame:CGRectMake(    50,75,_motherUIView.frame.size.width-100 ,40 )] ;
    [_welcomeMessageView setFont:[UIFont boldSystemFontOfSize:20 ]];

    
    [_welcomeMessageView disabledBackground];
    _welcomeMessageView.textColor = [UIColor  colorWithDisplayP3Red:236 green:0 blue:140 alpha:1.0];
    [_welcomeMessageView setBackgroundColor:[UIColor clearColor]];
    //[_motherUIView setBackgroundColor:[UIColor whiteColor]];
    //[_motherUIView setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    _backGroundPicture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NND_GardenPortrait"]];
    _logo =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NND_Logo_Stacked_RGB"]];
    [_logo               setFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2-_welcomeMessageView.frame.size.width/4, [[UIApplication sharedApplication] statusBarFrame].size.height,_logo.frame.size.width/8 , _logo.frame.size.height/8)];
    [_backGroundPicture  setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    
    
     _getStarted= [[UIButton alloc]init] ;
    [_getStarted setFrame:CGRectMake(  [[UIScreen mainScreen] bounds].size.width/2-50,[[UIScreen mainScreen] bounds].size.width,   100,40  )  ] ;
    [_getStarted setTitle:(@"Get Started") forState:UIControlStateNormal];
    [_getStarted setBackgroundColor:[UIColor colorWithDisplayP3Red:236 green:0 blue:140 alpha:1.0]];
    [_getStarted setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];// setTextColor:[UIColor brownColor]];
    [_getStarted setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];// setTextColor:[UIColor brownColor]];
    [_getStarted addTarget:self.delegate action:@selector(callBackFunctioniForGetStarted:) forControlEvents:UIControlEventTouchUpInside];
    [_getStarted setEnabled:YES];
    _getStarted.adjustsImageWhenHighlighted = NO;
    _getStarted.selected= NO;
    _getStarted.layer.cornerRadius = 15; // this value vary as per your desire
    _getStarted.clipsToBounds = YES;
     /*
      [button_ addTarget:target
      action:@selector(event_button_click:)
      forControlEvents:UIControlEventTouchUpInside];
      
      */
    [_motherUIView insertSubview:_backGroundPicture atIndex:0 ];
    [_motherUIView insertSubview:_welcomeMessageView atIndex:1 ];
    [_motherUIView insertSubview:_logo atIndex:2 ];
    [_motherUIView insertSubview:_getStarted atIndex:3 ];
    
    
}

-(void) initalizeWelcomeMessage{
    
    //_welcomeMessage= [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
}
-(UIView*) getLoginUIView{
    return _motherUIView;
    }


-(void)callBackFunctioniForGetStarted:(id*)returnedPointer{
    NSLog(@"callBackFunctioniForGetStarted");
    [self turnCardwithAnimationCompletion: nil];
    
}
 -(void)finished{
     NSLog(@"finished");
     
 }
- (void)turnCardwithAnimationCompletion:(NSObject*)inCompletion {

    
    [UIView transitionFromView:_motherUIView toView:_googleMapView duration:0.7 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished){
        // displayingFront = !displayingFront;
        [self goToGoogleUIView ];
    }]; /*
     transitionWithView:_motherUIView
                      duration:0.7
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        //[fromView removeFromSuperview];
                        //[containerView addSubview:toView];
                        
                    }
                    completion:^(BOOL finished){
                       // displayingFront = !displayingFront;
                        [self goToGoogleUIView ];
                    }];
              */
    
}

- (void)goToGoogleUIView {
    
    // get access to local location
    if ([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                               message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                              delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
            [alert show];
        }
    }
    

    _googleMapView  = [[UIView alloc] initWithFrame:_motherController.view.frame];
    [_googleMapView setBackgroundColor:[UIColor clearColor]];
    UIImageView *googleMapLogo =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NND_Bubbles_web"]];
    [googleMapLogo setFrame:(CGRectMake(0, 0, _motherController.view.frame.size.width, _motherController.view.frame.size.height/2))];
    [_googleMapView insertSubview:googleMapLogo atIndex:0];
    /*
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    _camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    _mapView = [GMSMapView mapWithFrame:_motherController.view.frame camera:_camera];
    _mapView.myLocationEnabled = YES;
    //self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = _mapView;

    [_googleMapView addSubview:_mapView];
    [_motherController.view addSubview:_googleMapView];
     */
    //_motherUIView =nil;
    //_motherUIView = _googleMapView;
    //NND_Goodbye_lowres
    
    
    
     
     _locationManager = [[CLLocationManager alloc] init];
     _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
     _locationManager.delegate = self;
     [_locationManager startUpdatingLocation];
     
      _camera = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(0, 0) zoom: 20];
     _mapView = [GMSMapView mapWithFrame:CGRectMake(0, _motherController.view.frame.size.height/2, _motherController.view.frame.size.width, _motherController.view.frame.size.height/2) camera:_camera];
     _mapView.myLocationEnabled = YES;
     //[self.viewForMap addSubview:mapView];
    
    
    
    [_googleMapView insertSubview:_mapView atIndex:1]; //_mapView];
    [_motherController.view addSubview:_googleMapView];

     
     
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    [_mapView animateToLocation:currentLocation.coordinate];
}

@end

