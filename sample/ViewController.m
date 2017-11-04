//
//  ViewController.m
//  sample
//
//  Created by ascratech2 on 29/05/17.
//  Copyright © 2017 AscraTech. All rights reserved.
//

#import "ViewController.h"
#import "JDDroppableView.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()<JDDroppableViewDelegate>
{
    CGFloat curAngle;
    CGFloat incAngle;
    NSArray *labels;
    JDDroppableView * dropview;
    UIView *viewObj;
    UIImageView *image;
    UIImageView *image2;
    UILabel *labelDescription;
    UIView *LayerView;
    UIView *dropTarget1;
    UILabel *labelSelectedMenu;
    CGFloat screenHeight;
    NSInteger labelsRadiusValue;
    NSInteger menuRadiusValue;
    NSInteger dropViewSizeValue;
    UIImageView *dottedView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    image2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60 )];
    
    if (screenHeight < 600)
    {
        menuRadiusValue = 85;
        labelsRadiusValue = 130;
        dropViewSizeValue = 70;
    }
    else if(screenHeight < 700)
    {
        menuRadiusValue = 95;
        labelsRadiusValue = 145;
        dropViewSizeValue = 90;
    }
    else
    {
        menuRadiusValue = 108;
        labelsRadiusValue = 160;
        dropViewSizeValue = 110;
    }
    
    // Dotted View
    dottedView = [[UIImageView alloc] init];
    dottedView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    dottedView.backgroundColor = [UIColor lightGrayColor];
    dottedView.frame = CGRectMake(0, 0, 220, 220);
    dottedView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 80);
    dottedView.layer.cornerRadius = 110;
//    dottedView.backgroundColor=[UIColor colorWithRed:247/255.0 green:178/255.0 blue:056/255.0 alpha:1];
//    [self.view addSubview:dottedView];
    
    // drop target 1
    dropTarget1 = [[UIView alloc] init];
    dropTarget1.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    dropTarget1.frame = CGRectMake(0, 0, dropViewSizeValue, dropViewSizeValue);
    dropTarget1.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 80);
    dropTarget1.layer.cornerRadius = dropViewSizeValue/2;
    dropTarget1.backgroundColor=[UIColor colorWithRed:247/255.0 green:178/255.0 blue:056/255.0 alpha:1];
    [self shadowForView:dropTarget1 redius:2 opacity:0.3f color:[UIColor blackColor]];
    
    //label for Selected menu
    labelSelectedMenu = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    labelSelectedMenu.center = CGPointMake(dropTarget1.frame.size.width/2, dropTarget1.frame.size.height/2);
    labelSelectedMenu.numberOfLines = 3;
    labelSelectedMenu.text = @"ISELL TIPS";
    labelSelectedMenu.font = [UIFont fontWithName:@"Helvetica-Bold" size:11];
    labelSelectedMenu.textAlignment = NSTextAlignmentCenter;
    labelSelectedMenu.textColor = [UIColor whiteColor];
    [dropTarget1 addSubview:labelSelectedMenu];
    
    
    labels = [[NSArray alloc] initWithObjects:@"ISELL TIPS",@"CYCLE STRATEGY",@"COMPETITION",@"WINNING EDGE",@"CLINICAL STUDIES",@"FAQ",@"IN CLINIC CHALLENGES",nil];
    curAngle = 0;
    incAngle = ( 360.0/(labels.count) )*3.14/180.0;
    CGPoint circleCenter = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 - 80);//CGPointMake(160, 200); /* given center */
    float circleRadius = menuRadiusValue;
    
    
    for (int i = 0; i<7; i++)
    {
        //View as Menu Button
        viewObj = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        viewObj.backgroundColor=[UIColor clearColor];
        image=[[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30 )];
        image.alpha = 0.7;
        [image setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",labels[i]]]];
        [viewObj addSubview:image];
        viewObj.layer.cornerRadius = 20;
        viewObj.backgroundColor=[UIColor whiteColor];
        [self shadowForView:viewObj redius:2 opacity:0.3f color:[UIColor blackColor]];

        
        //DroppableView
        dropview = [[JDDroppableView alloc] initWithDropTarget: dropTarget1];
        [dropview addDropTarget:dropTarget1];
        dropview.layer.cornerRadius = 30.0;
        dropview.frame = CGRectMake(0, 0, 60, 60);
        dropview.center = CGPointMake(self.view.frame.size.width/2 - 50, self.view.frame.origin.y - 50);
        dropview.delegate = self;
        dropview.tag = i;
        [self shadowForView:dropview redius:5 opacity:0.8f color:[UIColor whiteColor]];
        
        CGPoint buttonCenter;
        buttonCenter.x = circleCenter.x + cos(curAngle)*circleRadius;
        buttonCenter.y = circleCenter.y + sin(curAngle)*circleRadius;
        dropview.transform = CGAffineTransformRotate(dropview.transform, 0);
        dropview.center = buttonCenter;
        
        viewObj.transform = CGAffineTransformRotate(viewObj.transform, 0);
        viewObj.center = buttonCenter;

        [self.view addSubview:viewObj];
        [self.view addSubview:dropview];
        curAngle += incAngle;
    }
    
    LayerView=[[UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    LayerView.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    LayerView.hidden=YES;
    [self.view addSubview:LayerView];
    [self.view addSubview:dropTarget1];
    
    //For arranging Menu Titles in circular manner
    circleRadius = labelsRadiusValue;
    for (int i = 0; i<7; i++)
    {
        labelDescription = [[UILabel alloc]init ];//]WithFrame:CGRectMake(0, 0, 70, 40)];
        labelDescription.frame = CGRectMake(0, 0, 70, 40);
        labelDescription.numberOfLines = 0;
        labelDescription.text = labels[i];//@"Product Description";
        labelDescription.font = [UIFont fontWithName:@"Helvetica" size:10];
        labelDescription.textAlignment = NSTextAlignmentCenter;
//        [labelDescription sizeToFit];
        
        CGPoint buttonCenter;
        buttonCenter.x = circleCenter.x + cos(curAngle)*circleRadius;
        buttonCenter.y = circleCenter.y + sin(curAngle)*circleRadius;
        labelDescription.transform = CGAffineTransformRotate(labelDescription.transform, 0);
        labelDescription.center = buttonCenter;
        
        curAngle += incAngle;
        [self.view addSubview:labelDescription];
    }

}

#pragma JDDroppableViewDelegate

- (void)droppableViewBeganDragging:(JDDroppableView*)view;
{
    [UIView animateWithDuration:0.33 animations:^{
        view.backgroundColor = [UIColor orangeColor];
        view.alpha = 0.8;
        [image2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",labels[view.tag]]]];
        [view addSubview:image2];
        LayerView.hidden=NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)droppableViewEndedDragging:(JDDroppableView*)view onTarget:(UIView *)target
{
    NSLog(@"view tag: %ld",(long)view.tag);
    NSLog(@"labels[view.tag]: %@",labels[view.tag]);
//    view.backgroundColor = [UIColor clearColor];
//    [image2 removeFromSuperview];
//    LayerView.hidden=YES;
    
    if (!target) {
        
    } else {
        view.backgroundColor = [UIColor clearColor];
        [image2 removeFromSuperview];
        LayerView.hidden=YES;
    }
    
    [UIView animateWithDuration:0.33 animations:^{
        if (!target) {
            view.backgroundColor = [UIColor clearColor];
            [image2 removeFromSuperview];
            LayerView.hidden=YES;
            view.backgroundColor = [UIColor clearColor];
        } else {
            CABasicAnimation *animation = [self spinAnimationWithDuration:0.33 clockwise:YES repeat:NO];
            [labelSelectedMenu.layer addAnimation:animation forKey:@"rotationAnimation"];
            labelSelectedMenu.text = labels[view.tag];
            view.backgroundColor = [UIColor clearColor];
        }
        view.alpha = 1.0;
    }];
}

- (void)droppableView:(JDDroppableView*)view enteredTarget:(UIView*)target
{
    [UIView animateWithDuration:0.2 animations:^{
        target.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
}

- (void)droppableView:(JDDroppableView*)view leftTarget:(UIView*)target
{
    [UIView animateWithDuration:0.2 animations:^{
        target.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (BOOL)shouldAnimateDroppableViewBack:(JDDroppableView*)view wasDroppedOnTarget:(UIView*)target
{
    [self droppableView:view leftTarget:target];
    
    if (target == dropTarget1) {
        return YES;
    }
    
//    // animate out and remove view
//    [UIView animateWithDuration:0.33 animations:^{
//        view.transform = CGAffineTransformMakeScale(0.2, 0.2);
//        view.alpha = 0.2;
//        view.center = target.center;
//    } completion:^(BOOL finished) {
//        [view removeFromSuperview];
//    }];
    
    // update layout
//    [self relayout];
//    [self.scrollView flashScrollIndicators];
    
    return NO;
}

- (CABasicAnimation *)spinAnimationWithDuration:(CGFloat)duration clockwise:(BOOL)clockwise repeat:(BOOL)repeats
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.toValue = clockwise ? @(M_PI * 2.0) : @(M_PI * -2.0);
    anim.duration = duration;
    anim.cumulative = YES;
    anim.repeatCount = repeats ? CGFLOAT_MAX : 0;
    return anim;
}

-(void)shadowForView : (UIView *)view redius:(NSInteger)redius opacity:(CGFloat)opacity color:(UIColor*)color
{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = opacity;
    view.layer.shadowRadius = redius;
    view.layer.shadowColor = color.CGColor;//[UIColor color].CGColor;
}

- (CAShapeLayer *) addDashedBorderWithColor: (CGColorRef) color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    CGSize frameSize = self.view.frame.size;
    
    CGRect shapeRect = CGRectMake(0.0f, 0.0f, frameSize.width, frameSize.height);
    [shapeLayer setBounds:shapeRect];
    [shapeLayer setPosition:CGPointMake( frameSize.width/2,frameSize.height/2)];
    
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:color];
    [shapeLayer setLineWidth:5.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],
      nil]];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:shapeRect cornerRadius:15.0];
    [shapeLayer setPath:path.CGPath];
    
    return shapeLayer;
}
@end
