//
//  ViewController.m
//  Calculator
//
//  Created by Jillian Zhong on 2/8/16.
//  Copyright © 2016 Jillian Zhong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // create buttons
    int tag = 0;    // tag #
    NSInteger size = self.view.frame.size.width / 4;    // height and width of each button
    NSInteger topMargin = self.view.frame.size.height - (rows * size);   // space to top of container
    NSInteger buttonX;  // x location of button
    NSInteger buttonY;  // y location of button
    
    for(int y = 0; y < rows; y++){
        for(int x = 0; x < columns; x++){
            
            buttonX = x * size;
            buttonY = (y * size) + topMargin;
            
            buttons[x][y] = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            buttons[x][y].frame = CGRectMake(buttonX, buttonY, size, size);
            [buttons[x][y] addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [buttons[x][y] setTag:tag];
            [buttons[x][y] setTitle:[self getButtonLabel:tag] forState:UIControlStateNormal];
            
            [self.view addSubview:buttons[x][y]];
            
            tag++;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) buttonClicked:(UIButton*)button{
    
}

// helper function to pick button label
- (NSString*) getButtonLabel:(NSInteger)tag{
    
    if(tag == 0){
        return @"C";
    }
    else if(tag == 1){
        return @"()";
    }
    else if(tag == 2){
        return @"+/-";
    }
    else if(tag == 3){
        return @"÷";
    }
    else if(tag == 4){
        return @"7";
    }
    else if(tag == 5){
        return @"8";
    }
    else if(tag == 6){
        return @"9";
    }
    else if(tag == 7){
        return @"x";
    }
    else if(tag == 8){
        return @"4";
    }
    else if(tag == 9){
        return @"5";
    }
    else if(tag == 10){
        return @"6";
    }
    else if(tag == 11){
        return @"-";
    }
    else if(tag == 12){
        return @"1";
    }
    else if(tag == 13){
        return @"2";
    }
    else if(tag == 14){
        return @"3";
    }
    else if(tag == 15){
        return @"+";
    }
    else if(tag == 16){
        return @"0";
    }
    else if(tag == 17){
        return @".";
    }
    else if(tag == 18){
        return @"←";
    }
    else{
        return @"=";
    }
}
@end
