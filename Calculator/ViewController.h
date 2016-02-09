//
//  ViewController.h
//  Calculator
//
//  Created by Jillian Zhong on 2/8/16.
//  Copyright © 2016 Jillian Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

// buttons
#define columns 4
#define rows 5

@interface ViewController : UIViewController{
    UIButton *buttons[columns][rows];
}

// screen displays
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UITextField *output;

@property (strong, nonatomic) NSMutableString *inputCalcs;

@end

