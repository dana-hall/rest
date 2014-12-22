//
//  ViewController.m
//  Rest
//
//  Created by Dana Hall on 12/20/14.
//  Copyright (c) 2014 Dana Hall. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *location;

@end

@implementation ViewController

- (IBAction)fetchGreeting;
{
    [self loadGreeting:@"http://rest-service.guides.spring.io/greeting"];
}

- (IBAction)fetchLocalGreeting;
{
    [self loadGreeting:@"http://localhost:8081/api/howdyworld"];
}

- (void)loadGreeting:(NSString *)restUrl
{
    NSURL *url = [NSURL URLWithString:restUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             self.greetingContent.text = [greeting objectForKey:@"content"];
             _location = [greeting objectForKey:@"location"];
             
             // if location is null, then it is the remote call and take the value and display the id.
             // if location is not null then it is local and we want to use a random number for the id.
             if(_location == nil) {
                 self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
                 self.greetingLocation.text = @"Remote";
             }
             else {
                 NSInteger randomNumber = arc4random() % 99999;
                 self.greetingId.text = @(randomNumber).stringValue;
                 self.greetingLocation.text = _location;
             }
         }
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchGreeting];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
