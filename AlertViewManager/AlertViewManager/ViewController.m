//
//  ViewController.m
//  AlertViewManager
//
//  Created by Jacue on 2017/7/6.
//  Copyright © 2017年 Jacue. All rights reserved.
//

#import "ViewController.h"
#import "LNAlertView.h"
#import "LNActionSheet.h"
#import "LNAlertManager.h"
#import "View1.h"
#import "View2.h"
#import "View3.h"
#import "View4.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)level1:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        View1 *view = [[View1 alloc] initWithFrame:self.view.bounds];
        
        [[LNAlertManager sharedManager] show:view showBlock:^{
            [self.view addSubview:view];
        }];
    });
}

- (IBAction)level2:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        View2 *view = [[View2 alloc] initWithFrame:self.view.bounds];
        
        [[LNAlertManager sharedManager] show:view showBlock:^{
            [self.view addSubview:view];
        }];
    });
}

- (IBAction)level3:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        View3 *view = [[View3 alloc] initWithFrame:self.view.bounds];
        
        [[LNAlertManager sharedManager] show:view showBlock:^{
            [self.view addSubview:view];
        }];
    });
}

- (IBAction)level4:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        View4 *view = [[View4 alloc] initWithFrame:self.view.bounds];
        
        [[LNAlertManager sharedManager] show:view showBlock:^{
            [self.view addSubview:view];
        }];
    });
}


- (IBAction)showAlertView1:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        LNAlertView *alert = [[LNAlertView alloc] initWithTitle:@"LNAlertView" message:nil delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
        
        [[LNAlertManager sharedManager] show:alert showBlock:^{
            [alert show];
        }];
    });

}

- (IBAction)showAlertView2:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        LNActionSheet *sheet = [[LNActionSheet alloc] initWithTitle:@"LNActionSheet" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Confirm" otherButtonTitles:@"Others", nil];
        
        [[LNAlertManager sharedManager] show:sheet showBlock:^{
            [sheet showInView:self.view];
        }];
    });
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
