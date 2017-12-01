//
//  AppDelegate.h
//  iCheckIn
//
//  Created by Kian Davoudi-Rad on 2017-10-02.
//  Copyright © 2017 Kian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#include "Common.h"
@import CoreLocation;
@import LocalAuthentication;
@class GoogleLogInView;
@protocol GoogleLogInViewProtocol <NSObject>

@optional
-(void)callBackFunctioniForGetStarted:(id*)returnedPointer;

@end

@interface GoogleLogInView : UIViewController <NSObject,GoogleLogInViewProtocol,CLLocationManagerDelegate>

@property(assign, nonatomic) id<GoogleLogInViewProtocol> delegate;

- (instancetype)initWithMainController:(UIViewController*)incomingMotherController andDelegateMethod:(id*)commonServices;

- (UIView*) getLoginUIView;

@end

