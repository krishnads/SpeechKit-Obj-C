//
//  ViewController.h
//  SpeechKit Reference
//
//  Created by Matt Houston on 7/4/15.
//  Copyright (c) 2015 SpeechKit Reference. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpeechKit/SpeechKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <SpeechKitDelegate, SKRecognizerDelegate>

//handles entire recognition process.
//recording to server communication
@property (strong, nonatomic) SKRecognizer *voiceSearch;
@property (strong, nonatomic) AppDelegate *appDelegate;

//IBOutlets
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIButton *micRecord;

- (IBAction)recordButtonTapped:(id)sender;




@end

