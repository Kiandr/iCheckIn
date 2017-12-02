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
@property (strong, nonatomic) UIButton *finishButton;
@property (strong, nonatomic) UIImageView *backGroundPicture;
@property (strong, nonatomic) UIImageView *logo ;
@property (strong, nonatomic)    UIView *successView;
@property (strong, nonatomic)UITextField *welcomeMessageView;
@property (strong, nonatomic) NSString *welcomeMessageString;
@property (strong, nonatomic)UIImageView *googleMapLogo;
@property (strong, nonatomic)UIView *googleMapView;
@property (strong, nonatomic) GMSMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) GMSCameraPosition *camera;
@property (strong, nonatomic)CLLocation *currentLocation;
@property (assign, nonatomic)BOOL *updateVal;
@property (strong, nonatomic) UIButton *checkInButton;
@property (strong,nonatomic) NSString *fName;
@property(strong, nonatomic)UILabel *fromLabel;
@property(strong, nonatomic) UILabel *successLable;
@property(strong, nonatomic) NSString *successString;
@end

@implementation GoogleLogInView

@synthesize delegate;

- (instancetype)initWithMainController:(UIViewController*)incomingMotherController andDelegateMethod:(id *)commonServices
{
    self = [super init];
    if (self) {
        delegate = self;
        _motherController = incomingMotherController;
        //[incomingMotherController.view addSubview:_motherUIView];
        _updateVal= 1;
        [self startUpSequence];
        
        [self buildFirstName];
        [self buildUIViewCheckIn];
        
        
        
        
        
        
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
    [_welcomeMessage setEditable:NO];
    
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
    _googleMapLogo =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NND_Bubbles_web"]];
    [_googleMapLogo setFrame:(CGRectMake(0, 0, _motherController.view.frame.size.width, _motherController.view.frame.size.height/2))];
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
     
      _camera = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(0, 0) zoom: 13];
     _mapView = [GMSMapView mapWithFrame:CGRectMake(0, _motherController.view.frame.size.height/2, _motherController.view.frame.size.width, _motherController.view.frame.size.height/2) camera:_camera];
     _mapView.myLocationEnabled = YES;
    [self BuildSuccessView];
    
    
    // findme
    [_googleMapView insertSubview:_googleMapLogo atIndex:0];
    [_googleMapView insertSubview:_checkInButton atIndex:2];
    [_googleMapView insertSubview:_mapView       atIndex:1];
    [_googleMapView insertSubview:_fromLabel     atIndex:2];

    
    //[_motherController.view addSubview:_successView];
    [_motherController.view addSubview:_googleMapView];

     
     
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _currentLocation = [locations lastObject];
    [_mapView animateToLocation:_currentLocation.coordinate];
    if (_updateVal){
        [self drawDirection];
        _updateVal = 0;
    }
}


-(void)drawDirection{
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:49.2827291 longitude:-123.1207375];
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"Bobby";
    marker.map = _mapView;
    
    NSString *originString = [NSString stringWithFormat:
                           @"%@?origin=%f,%f&destination=%f,%f&mode=driving&sensor=true&key=%@",
                           @"https://maps.googleapis.com/maps/api/directions/json",
                           _currentLocation.coordinate.latitude,
                           _currentLocation.coordinate.longitude,
                           loc.coordinate.latitude,
                           loc.coordinate.longitude,
                           @"AIzaSyB6Ph3Ydv3GCB3EswzVenn5q0llSg362gY"];
    //NSString *originString = [NSString stringWithFormat:@"%f,%f", _currentLocation.coordinate.latitude, _currentLocation.coordinate.longitude];
//    NSString *destinationString = [NSString stringWithFormat:@"%f,%f", 123.12073750000002, 49.2827291];
//    NSString *directionsAPI = @"https://maps.googleapis.com/maps/api/directions/json?";
//    NSString *directionsUrlString = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&mode=driving", directionsAPI, originString, destinationString];
    NSURL *directionsUrl = [NSURL URLWithString:originString];
    //    _camera = [GMSCameraPosition cameraWithLatitude:-33.86 longitude:151.20
    
    NSURLSessionDataTask *fetchDirectionsTask = [[NSURLSession sharedSession] dataTaskWithURL:directionsUrl completionHandler:
                                                 ^(NSData *data, NSURLResponse *response, NSError *error)
                                                 {
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                     if(error)
                                                     {
                                                         //if(completionHandler)
                                                           //  completionHandler(nil);
                                                         NSLog(@"ERROR");
                                                         return;
                                                     }
                                                     
                                                     NSArray *routesArray = [json objectForKey:@"routes"];
                                                     
                                                     GMSPolyline *polyline = nil;
                                                     if ([routesArray count] > 0)
                                                     {
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             NSDictionary *routeDict = [routesArray objectAtIndex:0];
                                                             NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                                                             NSString *points = [routeOverviewPolyline objectForKey:@"points"];
                                                             GMSPolyline *polyline = [GMSPolyline polylineWithPath: [GMSPath pathFromEncodedPath: points]];
                                                             polyline.map = _mapView;
                                                             polyline.strokeColor = [UIColor colorWithRed:0/255.0 green:4/255.0 blue:255/255.0 alpha:1.0];
                                                             polyline.strokeWidth = 4.0f;
                                                         });
                                                     };
                                                     
                                                     
                                                     //if(completionHandler)
                                                       //  completionHandler(polyline);
                                                 }];
    [fetchDirectionsTask resume];

    
}


 ////
 //@property(strong, nonatomic) UILabel *successLable;
 //@property(strong, nonatomic) NSString *successString;

 
 -(void)buildSuccessMessage{
 //NSDate *today = [[NSDate alloc] initWithTimeIntervalSince1970:100];
 
//NSDate *today = [NSDate date];
//NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//[dateFormat setDateFormat:@"dd/MM/yyyy"];
//NSString *dateString = [dateFormat stringFromDate:today];

_successString=[[NSString alloc] initWithString:@" You have successfully checkedin, please click finish button."];

//UIFont * customFont = [UIFont fontWithName:CIDetectorAccuracy size:12]; //custom font
NSString * text = _successString;

//    CGSize labelSize = [text sizeWithFont:UIFontTextStyleBody constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];

_successLable = [[UILabel alloc]initWithFrame:CGRectMake(0,[[UIApplication sharedApplication] statusBarFrame].size.height, [[UIScreen mainScreen] bounds].size.width, 80)];
_successLable.text = text;
_successLable.textColor =[UIColor whiteColor];
//_fromLabel.font = customFont;
_successLable.numberOfLines = 2;
_successLable.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
_successLable.adjustsFontSizeToFitWidth = YES;
_successLable.adjustsLetterSpacingToFitWidth = YES;
_successLable.minimumScaleFactor = 10.0f/12.0f;
_successLable.clipsToBounds = YES;
_successLable.backgroundColor = [UIColor  colorWithDisplayP3Red:236 green:0 blue:140 alpha:1.0];

_successLable.textAlignment = NSTextAlignmentCenter;
_successLable.font = [_successLable.font fontWithSize:25];




}

 ////






-(void)buildFirstName{
    //NSDate *today = [[NSDate alloc] initWithTimeIntervalSince1970:100];
/*    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *today10am = [calendar dateFromComponents:components];
    [components setMonth:4];
    [components setDay:26];
    [components setHour:10];
    [components setSecond:3];
    [components setWeekday:1];
    
  */
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    _fName=[[NSString alloc] initWithFormat:@" John Zenetti :  %@",dateString];
    
    //UIFont * customFont = [UIFont fontWithName:CIDetectorAccuracy size:12]; //custom font
    NSString * text = _fName;
    
//    CGSize labelSize = [text sizeWithFont:UIFontTextStyleBody constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    
    _fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,[[UIApplication sharedApplication] statusBarFrame].size.height, [[UIScreen mainScreen] bounds].size.width, 40)];
    _fromLabel.text = text;
    _fromLabel.textColor =[UIColor whiteColor];
    //_fromLabel.font = customFont;
    _fromLabel.numberOfLines = 1;
    _fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    _fromLabel.adjustsFontSizeToFitWidth = YES;
    _fromLabel.adjustsLetterSpacingToFitWidth = YES;
    _fromLabel.minimumScaleFactor = 10.0f/12.0f;
    _fromLabel.clipsToBounds = YES;
    _fromLabel.backgroundColor = [UIColor  colorWithDisplayP3Red:236 green:0 blue:140 alpha:1.0];
    
    _fromLabel.textAlignment = NSTextAlignmentCenter;
    _fromLabel.font = [_fromLabel.font fontWithSize:25];
    
    
    
    
}


-(void)buildUIViewCheckIn{
    _checkInButton =[[UIButton alloc] init];
    [_checkInButton setFrame:CGRectMake(  [[UIScreen mainScreen] bounds].size.width/2-(150/2),[[UIScreen mainScreen] bounds].size.height/2-80,   150,40  )  ];
    [_checkInButton setTitle:(@"Check In Now") forState:UIControlStateNormal];
    [_checkInButton setBackgroundColor:[UIColor colorWithDisplayP3Red:236 green:0 blue:140 alpha:1.0]];
    [_checkInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];// setTextColor:[UIColor brownColor]];
    [_checkInButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];// setTextColor:[UIColor brownColor]];
    [_checkInButton addTarget:self.delegate action:@selector(callBackFunctioniForChecIn:) forControlEvents:UIControlEventTouchUpInside];
    [_checkInButton setEnabled:YES];
    _checkInButton.adjustsImageWhenHighlighted = NO;
    _checkInButton.selected= YES;
    _checkInButton.layer.cornerRadius = 15; // this value vary as per your desire
    _checkInButton.clipsToBounds = YES;
    
    
    
}

-(void)BuildSuccessView{

    _successView   = [[UIView alloc] initWithFrame:_motherController.view.frame];
    [_successView setBackgroundColor:[UIColor clearColor]];
    _successView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NND_Gardening"]];
    [_successView setFrame:(CGRectMake(0, 0, _motherController.view.frame.size.width, _motherController.view.frame.size.height))];
    
    [self buildSuccessMessage];
    [self builFinishButton];
    
    [_successView insertSubview:_successLable   atIndex:0];
    [_successView insertSubview:_finishButton   atIndex:1];
    //[_motherUIView addSubview:_successView];
}

-(void)callBackFunctioniForChecIn:(id*)returnedPointer{
    NSLog(@"Here is the login button");
    
    [UIView transitionFromView:_googleMapView toView:_successView duration:0.7 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished){
        // displayingFront = !displayingFront;
        //[self goToGoogleUIView ];
    }];
    
}

-(void)builFinishButton{
    _finishButton= [[UIButton alloc]init] ;
    [_finishButton setFrame:CGRectMake(  [[UIScreen mainScreen] bounds].size.width/2-50,[[UIScreen mainScreen] bounds].size.height-40*2,   100,40  )  ] ;
    [_finishButton setTitle:(@"Finish") forState:UIControlStateNormal];
    [_finishButton setBackgroundColor:[UIColor colorWithDisplayP3Red:236 green:0 blue:140 alpha:1.0]];
    [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];// setTextColor:[UIColor brownColor]];
    [_finishButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];// setTextColor:[UIColor brownColor]];
    [_finishButton addTarget:self.delegate action:@selector(callBackFunctioniForFinishButton:) forControlEvents:UIControlEventTouchUpInside];
    [_finishButton setEnabled:YES];
    _finishButton.adjustsImageWhenHighlighted = NO;
    _finishButton.selected= NO;
    _finishButton.layer.cornerRadius = 15; // this value vary as per your desire
    _finishButton.clipsToBounds = YES;
}

-(void)callBackFunctioniForFinishButton:(id*)returnedPointer{
    
    
    [UIView transitionFromView:_successView toView:_motherUIView duration:0.7 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished){
        // displayingFront = !displayingFront;
        //[self goToGoogleUIView ];
    }];
    
    
    
}
@end

