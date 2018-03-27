//
//  ViewController.m
//  VCAloneNumFieldDemo
//
//  Created by 任维超 on 2018/3/27.
//  Copyright © 2018年 vchao. All rights reserved.
//

#import "ViewController.h"
#import "VCAloneNumField.h"

@interface ViewController ()<VCAloneNumFieldDelegate>

@property (nonatomic, strong) VCAloneNumField *numField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.numField) {
        self.numField = [[VCAloneNumField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 60)];
        self.numField.delegate = self;
        self.numField.backgroundColor = [UIColor whiteColor];
        self.numField.secureTextEntry = NO;
        self.numField.numLength = 4;
        self.numField.inputingColor = [UIColor colorWithRed:247/255.f green:237/255.f blue:200/255.f alpha:1.0];
        [self.view addSubview:self.numField];
        
        [self.numField autoBecomeFirstResponder];
    }
}

- (void)numField:(VCAloneNumField *)numField inputNum:(NSString *)num
{
    NSLog(@"%@", num);
    if (num.length >= self.numField.numLength) {
        [self.numField endEditing:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
