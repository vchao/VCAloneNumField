# VCAloneNumField

![Image text](https://github.com/vchao/VCAloneNumField/blob/master/iPhoneX-2018-03-27.png)

###### 密码验证码输入

```c

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

```
