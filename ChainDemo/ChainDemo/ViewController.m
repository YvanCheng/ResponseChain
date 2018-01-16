//
//  ViewController.m
//  ChainDemo
//
//  Created by chengyulong on 2018/1/4.
//  Copyright © 2018年 chengyulong. All rights reserved.
//

#import "ViewController.h"
#import "ResponsabilityChainList.h"

typedef NS_ENUM(NSUInteger, One) {
    One_First = 1,
    One_Second,
    One_Third
};

typedef NS_ENUM(NSUInteger, Two) {
    Two_First = 1,
    Two_Second,
    Two_Third
};

typedef NS_ENUM(NSUInteger, Three) {
    Three_First = 1,
    Three_Second,
    Three_Third
};

typedef NS_ENUM(NSUInteger, Four) {
    Four_First = 1,
    Four_Second,
    Four_Third
};

@interface ViewController ()

@property (nonatomic, strong) ResponsabilityChainList *chain;
@property (nonatomic, strong) UILabel *lb_demo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *temp = @[].mutableCopy;
    /***************************************************** 方法一 *************************************************************/
    ResponsabilityChain *chainFirst = [ResponsabilityChain instanceChain:self
                                                                selector:@selector(logEnumOne)];
    NSArray *condition1 = @[@(One_First),@(Two_First),@(Four_First)];
    NSArray *condition2 = @[@(One_First),@(Two_Second),@(Three_Second),@(Four_Second)];
    NSArray *condition3 = @[@(One_First),@(Two_Third),@(Three_Third),@(Four_Third)];
    
    [chainFirst addEnumStringArray:@[condition1,condition2,condition3]];
    [temp addObject:chainFirst];
    
    /****************************************************** 方法二  ************************************************************/
    ResponsabilityChain *chainSecond = [ResponsabilityChain instanceChain:self
                                                                 selector:@selector(logEnumTwo)];
    [temp addObject:chainSecond];
    
    /****************************************************** 方法三  ************************************************************/
    ResponsabilityChain *chainThird = [ResponsabilityChain instanceChain:self
                                                                selector:@selector(logEnumThree)];
    [temp addObject:chainThird];
    
    /****************************************************** 方法四  ************************************************************/
    ResponsabilityChain *chainFourth = [ResponsabilityChain instanceChain:self
                                                                 selector:@selector(logEnumFour)];
    [temp addObject:chainFourth];
    
    /****************************************************** 方法五  ************************************************************/
    ResponsabilityChain *chainFifth = [ResponsabilityChain instanceChain:self
                                                                selector:@selector(logEnumFive)];
    [temp addObject:chainFifth];
    
    self.chain = [ResponsabilityChainList instanceResponsabilityChain:temp defaultTarget:self defaultSelector:@selector(logDefault)];
    
    UIButton *btn_demo = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [btn_demo setBackgroundColor:[UIColor blueColor]];
    [btn_demo addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_demo];
    
    self.lb_demo = [[UILabel alloc] initWithFrame:CGRectMake(80, 180, 200, 100)];
    self.lb_demo.backgroundColor = [UIColor blackColor];
    self.lb_demo.textColor = [UIColor whiteColor];
    [self.view addSubview:self.lb_demo];
    
}

- (void)clickBtn:(UIButton *)sender{
    [self.chain implementationMethodByConditionArray:@[@(One_First),@(Two_Second),@(Three_Second),@(Four_Second)]];
}

-(NSInteger)randomFromArray:(NSArray<NSNumber *> *)array{
    NSInteger tt = arc4random()%array.count;
    return array[tt].integerValue;
}
#pragma mark - Method
- (void)logDefault{
    NSLog(@">>>> 打印默认方法");
    self.lb_demo.text = @"默认方法";
}

- (void)logEnumOne{
    NSLog(@">>>> 打印第一个方法");
    self.lb_demo.text = @"第一个方法";
}

- (void)logEnumTwo{
    NSLog(@">>>> 打印第二个方法");
    self.lb_demo.text = @"第二个方法";
}

- (void)logEnumThree{
    NSLog(@">>>> 打印第三个方法");
    self.lb_demo.text = @"第三个方法";
}

- (void)logEnumFour{
    NSLog(@">>>> 打印第四个方法");
    self.lb_demo.text = @"第四个方法";
}

- (void)logEnumFive{
    NSLog(@">>>> 打印第五个方法");
    self.lb_demo.text = @"第五个方法";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
