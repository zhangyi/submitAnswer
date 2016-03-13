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
	
//	self.txfNum.keyboardType = UIKeyboardTypeDecimalPad;
	
	self.txfNum.delegate = self;
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
	[self submitAnswerCommonHandler];
	
}

- (void)submitAnswerCommonHandler {
	self.nTimes += 1;
	
	
	NSString *resultText = self.txfNum.text;
	
	//判断是否为纯数字
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d{1,}$"
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&error];
	
	NSUInteger numberOfMatches = [regex numberOfMatchesInString:resultText
														options:0
														  range:NSMakeRange(0, [resultText length])];
	
	if (numberOfMatches < 1) {
		
		NSString *errMessage = nil;
		
		if ([resultText isEqualToString:@""]) {
			errMessage = @"请输入数字后再进行提交";
		} else {
			errMessage = @"输入的格式不正确，请输入数字";
		}
		
		UIAlertController * alert=   [UIAlertController
									  alertControllerWithTitle:@"系统提示"
									  message:errMessage
									preferredStyle:UIAlertControllerStyleAlert];
//									  preferredStyle:UIAlertControllerStyleActionSheet];
		
		
		UIAlertAction* ok = [UIAlertAction
							 actionWithTitle:@"确定"
							 style:UIAlertActionStyleDefault
							 handler:^(UIAlertAction * action)
							 {
								 //								 [alert dismissViewControllerAnimated:YES completion:nil];
								 
							 }];
		UIAlertAction* cancel = [UIAlertAction
								 actionWithTitle:@"关闭"
								 style:UIAlertActionStyleDefault
								 handler:^(UIAlertAction * action)
								 {
									 //									 [alert dismissViewControllerAnimated:YES completion:nil];
									 
								 }];
		
		[alert addAction:ok];
		[alert addAction:cancel];
		
		
		//		[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
		//			textField.placeholder = @"Username";
		//		}];
		//		[alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
		//			textField.placeholder = @"Password";
		//			textField.secureTextEntry = YES;
		//		}];
		
		[self presentViewController:alert animated:YES completion:nil];
		
		
		return ;
	}
	
	
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[self.txfNum resignFirstResponder];
	
	[self submitAnswerCommonHandler];
	
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	
	return YES;
}

- (IBAction)hideKeyboard:(id)sender {
	[self hideKeyboardCommonHandler];
}

- (void)hideKeyboardCommonHandler {
	[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
