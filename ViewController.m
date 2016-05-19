//
//  ViewController.m
//  SunLayerDemo
//
//  Created by hzzc on 16/5/10.
//  Copyright © 2016年 hzzc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CAShapeLayer *layer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateLayer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)CreateLayer{

    layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 10.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    layer.strokeColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:layer];
    
    //创建贝塞尔
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200)
                                                        radius:80
                                                    startAngle:0
                                                      endAngle:2*M_PI
                                                     clockwise:NO];
    
    //关联Layer 和 贝塞尔
    layer.path = path.CGPath;
    
    CABasicAnimation *bAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bAnimation.fromValue = @(0.0);
    bAnimation.toValue = @(1.0);
    bAnimation.autoreverses = NO;
    bAnimation.duration = 5.0f;
    bAnimation.delegate = self;
    
    [layer addAnimation:bAnimation forKey:nil];
    
    //绘制周围黄色线条
    int count = 16;
    for (int i = 0; i < count; i++) {
        
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.lineWidth = 10.0f;
        lineLayer.lineJoin = kCALineJoinRound;
        lineLayer.lineCap = kCALineCapRound;
        lineLayer.fillColor = [UIColor clearColor].CGColor;
        lineLayer.strokeColor = [UIColor yellowColor].CGColor;
        
        [self.view.layer addSublayer:lineLayer];
        
        UIBezierPath *path2 = [UIBezierPath bezierPath];
        int x = 200 + 100*cos(2*M_PI/count*i);
        int y = 200 - 100*sin(2*M_PI/count*i);
        int len = 50;
        [path2 moveToPoint:CGPointMake(x, y)];
        [path2 addLineToPoint:CGPointMake(x + len*cos(2*M_PI/count*i), y - len*sin(2*M_PI/count*i))];
        lineLayer.path = path2.CGPath;
        [lineLayer addAnimation:bAnimation forKey:nil];
        
    }
    


}

//动画结束填充

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    layer.fillColor = [UIColor redColor].CGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
