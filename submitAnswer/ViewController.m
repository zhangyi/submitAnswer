//
//  ViewController.m
//  submitAnswer
//
//  Created by meteoric_cry on 16/3/13.
//  Copyright © 2016年 meteoric. All rights reserved.
//

#import "ViewController.h"

#define MAX_RANDOM_NUM 100;

@interface ViewController ()

@property(nonatomic, assign) int nRandomNum;
@property(nonatomic, assign) int nTimes;

@property (weak, nonatomic) IBOutlet UITextField *txfNum;


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self initGame];
	
	self.txfNum.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)initGame {
	int maxNum = MAX_RANDOM_NUM;
	self.nRandomNum = arc4random_uniform(maxNum);
	self.nTimes = 0;
	
	NSLog(@"random num : %d", self.nRandomNum);
}

//start new game
- (IBAction)onRestartNewGame:(id)sender {
	self.txfNum.text = @"";
	
	[self initGame];
}

//submit answer
- (IBAction)onSubmitAnswer:(id)sender {
	
	self.nTimes += 1;
	
	
	NSString *resultText = self.txfNum.text;
	
	int nInputNum = [resultText intValue];
	
	NSString *message = nil;
	
	if (nInputNum < self.nRandomNum) {
		message = @"你输入的数字太小啦";
	} else if (nInputNum > self.nRandomNum) {
		message = @"你输入的数字太大啦";
	} else {
		message = [NSString stringWithFormat:@"恭喜你，猜对啦！一共猜了%d次", self.nTimes];
	}
	
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"结果" message:message preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction *action = [UIAlertAction
							 actionWithTitle:@"确定"
							 style:UIAlertActionStyleDefault
							 handler:^(UIAlertAction *action) {
								 /*
								 [alert dismissViewControllerAnimated:YES completion:^{
									 NSLog(@"complete!");
								 }];
								  */
								 NSLog(@"show!");
							 }];
	
	[alert addAction:action];
	
	[self presentViewController:alert animated:YES completion:nil];
}




@end
