//
//  ViewController.h
//  Rest
//
//  Created by Dana Hall on 12/20/14.
//  Copyright (c) 2014 Dana Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;
@property (nonatomic, strong) IBOutlet UILabel *greetingLocation;

- (IBAction)fetchGreeting;
- (IBAction)fetchLocalGreeting;

- (void)loadGreeting:(NSString *)restUrl;

@end

