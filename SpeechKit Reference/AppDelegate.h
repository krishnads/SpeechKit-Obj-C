//
//  AppDelegate.h
//  SpeechKit Reference
//
//  Created by Matt Houston on 7/4/15.
//  Copyright (c) 2015 SpeechKit Reference. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpeechKit/SpeechKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setupSpeechKitConnection;


@end

