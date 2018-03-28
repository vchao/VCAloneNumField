//
//  VCAloneNumField.m
//  VCAloneNumFieldDemo
//
//  Created by 任维超 on 2018/3/27.
//  Copyright © 2018年 vchao. All rights reserved.
//

#import "VCAloneNumField.h"
#import "UIImage+VCAloneNumField.h"

@interface VCAloneNumField()

@property (nonatomic, strong) UITextField    *hiddenTextField;//

@property (nonatomic, strong) NSMutableArray *gridsArray;//网格
@property (nonatomic, strong) NSMutableArray *labelsArray;//明文

@property (nonatomic, strong) NSMutableArray *dotsArray;//密文

@end

@implementation VCAloneNumField

#pragma mark    -   set / get

/**
 *  在这里控制圆点的隐藏和显示
 *
 *  @param inputCount 当前用户输入的密码个数
 */
- (void)setInputCount:(NSInteger)inputCount
{
    inputCount = (inputCount > _numLength) ? _numLength : inputCount;
    _inputCount = inputCount;
    for (int i = 0; i < self.gridsArray.count; i++) {
        UIView *gridView = self.gridsArray[i];
        if (i != inputCount) {
            gridView.backgroundColor = [UIColor clearColor];
        }else{
            gridView.backgroundColor = _inputingColor;
        }
    }
    if (self.isSecureTextEntry) {
        for ( int i = 0 ; i < inputCount; i ++) {
            UIImageView *dotImageView = self.dotsArray[i];
            dotImageView.hidden = NO;
        }
        for (NSInteger i = inputCount; i < self.dotsArray.count; i ++) {
            UIImageView *dotImageView = self.dotsArray[i];
            dotImageView.hidden = YES;
        }
        
        for (int i = 0 ; i < self.labelsArray.count; i ++) {
            UILabel *label = self.labelsArray[i];
            label.hidden = YES;
        }
    } else {
        NSString *numText = self.hiddenTextField.text;
        for ( int i = 0 ; i < inputCount; i ++) {
            UILabel *label = self.labelsArray[i];
            label.text = [numText substringWithRange:NSMakeRange(i, 1)];
            [label sizeToFit];
            label.hidden = NO;
        }
        for (NSInteger i = inputCount; i < self.dotsArray.count; i ++) {
            UILabel *label = self.labelsArray[i];
            label.text = nil;
            label.hidden = YES;
        }
        for (int i = 0 ; i < self.dotsArray.count; i ++) {
            UIImageView *imageView = self.dotsArray[i];
            imageView.hidden = YES;
        }
    }
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    if (_secureTextEntry != secureTextEntry) {
        _secureTextEntry = secureTextEntry;
        self.inputCount = self.inputCount;
    }
}

- (void)setNumLength:(NSInteger)numLength
{
    if (_numLength != numLength) {
        _numLength = numLength;
        [self refreshUI];
    }
}

- (void)setGridLineColor:(UIColor *)gridLineColor
{
    _gridLineColor = gridLineColor;
    [self refreshUI];
}

- (void)setGridLineWidth:(CGFloat)gridLineWidth
{
    _gridLineWidth = gridLineWidth;
    [self refreshUI];
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    [self refreshUI];
}

- (void)setDotWidth:(CGFloat)dotWidth
{
    if (_dotWidth != dotWidth) {
        _dotWidth = dotWidth;
        [self refreshUI];
    }
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self refreshUI];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self refreshUI];
}

- (void)setInputingColor:(UIColor *)inputingColor
{
    _inputingColor = inputingColor;
    [self refreshUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _numLength = 6;
        _gridLineWidth = 0.5f;
        _gridLineColor = [UIColor blackColor];
        _dotWidth = 12.0f;
        _dotColor = [UIColor blackColor];
        _inputingColor = [UIColor colorWithRed:247/255.f green:237/255.f blue:200/255.f alpha:1.0];
        _secureTextEntry = YES;
        _inputCount = 0;
        _font = [UIFont systemFontOfSize:15];
        _textColor = [UIColor blackColor];
        [self initUI];
    }
    return self;
}

- (void)initUI{
    if (!self.hiddenTextField) {
        self.hiddenTextField = [[UITextField alloc] initWithFrame:self.bounds];
        self.hiddenTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.hiddenTextField.tintColor = [UIColor clearColor];
        self.hiddenTextField.textColor = [UIColor clearColor];
        [self.hiddenTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.hiddenTextField];
    }
    [self refreshUI];
}

/**
 *  懒加载成员属性
 */
- (NSArray *)dotsArray
{
    if (_dotsArray == nil) {
        NSMutableArray *dotsArray = [NSMutableArray array];
        for (int i = 0 ; i < _numLength; i ++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage circleAndStretchableImageWithColor:_dotColor size:CGSizeMake(_dotWidth, _dotWidth)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.userInteractionEnabled = NO;
            [self addSubview:imageView];
            [dotsArray addObject:imageView];
            imageView.hidden = YES;
        }
        _dotsArray = dotsArray;
    }
    
    return _dotsArray;
}

/**
 *  懒加载成员属性
 */
- (NSArray *)labelsArray
{
    if (_labelsArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:_numLength];
        for ( int i = 0 ; i < _numLength; i ++ ) {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = @"";
            titleLabel.numberOfLines = 1;
            titleLabel.textColor = _textColor;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = _font;
            titleLabel.hidden = YES;
            titleLabel.userInteractionEnabled = NO;
            [self addSubview:titleLabel];
            [array addObject:titleLabel];
        }
        _labelsArray = array;
    }
    
    return _labelsArray;
}

- (NSArray *)gridsArray
{
    if (_gridsArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:_numLength];
        CGFloat gridWidth = self.frame.size.height;
        for ( int i = 0 ; i < _numLength; i ++ ) {
            UIView *gridView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, gridWidth, gridWidth)];
            gridView.backgroundColor = [UIColor clearColor];
            gridView.layer.borderColor = _gridLineColor.CGColor;
            gridView.layer.borderWidth = _gridLineWidth;
            gridView.layer.masksToBounds = YES;
            gridView.layer.cornerRadius = gridWidth/2.f;
            gridView.userInteractionEnabled = NO;
            [self addSubview:gridView];
            [array addObject:gridView];
        }
        _gridsArray = array;
    }
    
    return _gridsArray;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageWidth = self.dotWidth;
    CGFloat imageHeight = self.dotWidth;
    CGFloat gridWidth = self.frame.size.height;
    CGFloat gridSpace = (self.frame.size.width - (gridWidth*_numLength)) / (_numLength - 1);//网格间距
    for (int i = 0; i < self.gridsArray.count; i++) {
        UIView *gridView = self.gridsArray[i];
        gridView.frame = CGRectMake(0, 0, gridWidth, gridWidth);
        gridView.center = CGPointMake(gridWidth/2.f + i*(gridWidth+gridSpace), self.frame.size.height/2.f);
    }
    for (int i = 0; i < self.dotsArray.count; i++) {
        UIImageView *imageView = self.dotsArray[i];
        [imageView setFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
        imageView.center = CGPointMake(gridWidth/2.f + i*(gridWidth+gridSpace), self.frame.size.height/2.f);
    }
    for (int i = 0; i < self.labelsArray.count; i++) {
        UILabel *label = self.labelsArray[i];
        label.frame = CGRectMake(0, 0, gridWidth, gridWidth);
        label.center = CGPointMake(gridWidth/2.f + i*(gridWidth+gridSpace), self.frame.size.height/2.f);
    }
    self.hiddenTextField.frame = self.bounds;
}

#pragma mark - 文本框内容改变

- (void)textChange:(UITextField *)textField {
    NSString *text = textField.text;
    if (text.length > _numLength) {
        //substringToIndex,index从0开始, 不包含最后index所指的那个字符,在这里接到的子串不包含6所指的字符
        text = [text substringToIndex:_numLength];
        textField.text = text;
    }
    // 刷新位数
    self.inputCount = textField.text.length;
    
    if ([self.delegate respondsToSelector:@selector(numField:inputNum:)]) {
        [self.delegate numField:self inputNum:textField.text];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark    -   private method

/**
 *  刷新UI
 */
- (void)refreshUI
{
    [self.dotsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.dotsArray = nil;
    [self.labelsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.labelsArray = nil;
    [self gridsArray];
    [self dotsArray];
    [self labelsArray];
    
    self.inputCount = self.inputCount;
    [self textChange:self.hiddenTextField];
}

- (void)autoBecomeFirstResponder
{
    if (!self.hiddenTextField.isFirstResponder) {
        [self.hiddenTextField becomeFirstResponder];
    }
}

@end
