//
//  ViewController.m
//  SpeechKit Reference
//
//  Created by Matt Houston on 7/4/15.
//  Copyright (c) 2015 SpeechKit Reference. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

//insert key to gaina access to API
const unsigned char SpeechKitApplicationKey[] = {0x6c, 0xa9, 0x56, 0xfa, 0x61, 0xe8, 0xb3, 0x95, 0x60, 0x46, 0x05, 0xb2, 0x28, 0x8c, 0x23, 0x43, 0x92, 0x68, 0x36, 0xa4, 0x0e, 0x9f, 0xa6, 0x20, 0xea, 0xb7, 0x79, 0x81, 0x3d, 0x81, 0x1b, 0xa9, 0x2a, 0x71, 0xa3, 0x8c, 0x59, 0x56, 0x21, 0xba, 0x9c, 0x26, 0x6c, 0xc4, 0xb2, 0x8f, 0x07, 0x44, 0xf7, 0x3e, 0xe8, 0x05, 0xdd, 0x8f, 0x25, 0xc8, 0x46, 0x9e, 0x49, 0x83, 0x1f, 0x64, 0x2c, 0x4a};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.messageLabel.text = @"Tap on the mic";
    self.activityIndicator.hidden = YES;
    self.activityIndicator.color = [UIColor redColor];
    
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.appDelegate setupSpeechKitConnection];
    
    self.searchTextField.returnKeyType = UIReturnKeySearch;
}

- (IBAction)recordButtonTapped:(id)sender {
    self.micRecord.selected = !self.micRecord.isSelected;
    
    // This will initialize a new speech recognizer instance
    if (self.micRecord.isSelected) {
        self.voiceSearch = [[SKRecognizer alloc] initWithType:SKSearchRecognizerType
                                                    detection:SKShortEndOfSpeechDetection
                                                     language:@"en_US"
                                                     delegate:self];
    }
    
    // This will stop existing speech recognizer processes
    else {
        if (self.voiceSearch) {
            [self.voiceSearch stopRecording];
            [self.voiceSearch cancel];
        }
    }
}

# pragma mark - SKRecognizer Delegate Methods

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer {
    self.messageLabel.text = @"Listening..";
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer {
    self.messageLabel.text = @"Done Listening..";
    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results {
    long numOfResults = [results.results count];
    
    if (numOfResults > 0) {
        // update the text of text field with best result from SpeechKit
        self.searchTextField.text = [results firstResult];
    }
    
    self.micRecord.selected = !self.micRecord.isSelected;
    
    if (self.voiceSearch) {
        [self.voiceSearch cancel];
    }
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion {
    self.micRecord.selected = NO;
    self.messageLabel.text = @"Connection error";
    self.activityIndicator.hidden = YES;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
