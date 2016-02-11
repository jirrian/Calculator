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
    
    self.inputCalcs = [NSMutableString stringWithString: @""];
    
    // hide default keyboards for textviews
    UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0,0,1,1)];
    self.input.inputView = dummyView;
    self.output.inputView = dummyView;
    
    self.output.delegate = self;
    
    // create buttons
    int tag = 0;    // tag #
    NSInteger size = self.view.frame.size.width / 4.0;    // height and width of each button
    NSInteger sizeX; // horizontal size of button
    float topMargin = self.view.frame.size.height - (rows * size);   // space to top of container
    NSInteger buttonX;  // x location of button
    NSInteger buttonY;  // y location of button
    
    for(int y = 0; y < rows; y++){
        for(int x = 0; x < columns; x++){
            
            // calculate button position and spacing
            if((y == 0 && x == 0) || (y == rows - 1 && x == columns - 2)){
                // first and last button are twice as wide
                sizeX = size * 2 + 2;
            }
            else{
                sizeX = size;
            }

            buttonX = x * (size + 2);
            
            buttonY = y * (size + 2) + topMargin;
        
            buttons[x][y] = [UIButton buttonWithType:UIButtonTypeCustom];
            buttons[x][y].titleLabel.font = [UIFont systemFontOfSize:30.0];
            
            // set background color of buttons
            if(x == columns - 1){
                buttons[x][y].backgroundColor = [UIColor colorWithRed:161/255.0 green:242/255.0 blue:29/255.0 alpha:1.0];
            }
            else if((y == 0 && x == 0) || (y == rows - 1 && x == columns - 2)){
                buttons[x][y].backgroundColor = [UIColor darkGrayColor];
            }
            else{
                buttons[x][y].backgroundColor = [UIColor lightGrayColor];
            }
            
            buttons[x][y].frame = CGRectMake(buttonX, buttonY, sizeX, size);
            [buttons[x][y] addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [buttons[x][y] setTag:tag];
            [buttons[x][y] setTitle:[self getButtonLabel:tag] forState:UIControlStateNormal];
            
            [self.view addSubview:buttons[x][y]];
            
            // skip next column if current button is a 2x wide one
            if((y == 0 && x == 0) || (y == rows - 1 && x == columns - 2)){
                x++;
            }
            tag++;
        }
    }
    
    // setting contraints for uitextfields
    [self.inputHeight setConstant:((topMargin - 24) * 0.3)];
    [self.outputHeight setConstant:((topMargin - 24) * 0.7)];
    
    self.output.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// allow user interaction with output textfield but no editing
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}

// actions depending on button clicked
- (void) buttonClicked:(UIButton*)button{
    
    // start new expression continuing result of previous if operand pressed after =
    // clear everything if number pressed
    if(button.tag == 2 || button.tag == 6 || button.tag == 10 || button.tag == 14){
        if([self.output.text isEqualToString: @"0"] == NO){
            [self.inputCalcs setString:self.output.text];
            
            self.done = NO;
        }
    }
    else if(button.tag != 2 && button.tag != 16 && button.tag != 17){
        if(self.done == YES){
            [self.inputCalcs setString:@""];
            
            self.input.text = self.inputCalcs;
            self.output.text = @"0";
            
            self.done = NO;
        }
    }
    
    if(button.tag == 0){
        [self.inputCalcs setString:@""];
        
        self.input.text = self.inputCalcs;
        self.output.text = @"0";
        
        self.done = NO;
    }
    else if(button.tag == 1){
        // delete last character
        if(self.inputCalcs.length > 0){
            [self.inputCalcs deleteCharactersInRange:NSMakeRange(self.inputCalcs.length-1, 1)];
            self.input.text = self.inputCalcs;
        }
    }
    else if(button.tag == 2){
        // replace existing operand with new pressed operand
        if ([self.inputCalcs hasSuffix:@"*"]
            || [self.inputCalcs hasSuffix:@"+"]
            || [self.inputCalcs hasSuffix:@"-"]){
            
            [self.inputCalcs deleteCharactersInRange:NSMakeRange(self.inputCalcs.length-1, 1)];
            
            // make number before floating point if not already
            if([self.inputCalcs rangeOfString:@"."].location == NSNotFound){
                [self.inputCalcs appendString:@".0"];
            }
            
            [self.inputCalcs appendString:@"/"];
            self.input.text = self.inputCalcs;
        }
        // append if not empty string or same operand already entered
        else if([self.inputCalcs isEqualToString: @""] == NO
                && [self.inputCalcs hasSuffix:@"/"] == NO){
            
            // make number before floating point if not already
            if([self.inputCalcs rangeOfString:@"."].location == NSNotFound){
                [self.inputCalcs appendString:@".0"];
            }
            
            [self.inputCalcs appendString:@"/"];
            self.input.text = self.inputCalcs;
        }
    }
    else if(button.tag == 3){
        [self.inputCalcs appendString:@"7"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 4){
        [self.inputCalcs appendString:@"8"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 5){
        [self.inputCalcs appendString:@"9"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 6){
        // replace existing operand with new pressed operand
        if ([self.inputCalcs hasSuffix:@"/"]
            || [self.inputCalcs hasSuffix:@"+"]
            || [self.inputCalcs hasSuffix:@"-"]){
            
            [self.inputCalcs replaceCharactersInRange:NSMakeRange(self.inputCalcs.length-1, 1) withString:@"*"];
            self.input.text = self.inputCalcs;
        }
        // append if not empty string or same operand already entered
        else if([self.inputCalcs isEqualToString: @""] == NO
                && [self.inputCalcs hasSuffix:@"*"] == NO){
            [self.inputCalcs appendString:@"*"];
            self.input.text = self.inputCalcs;
        }
    }
    else if(button.tag == 7){
        [self.inputCalcs appendString:@"4"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 8){
        [self.inputCalcs appendString:@"5"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 9){
        [self.inputCalcs appendString:@"6"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 10){
        // only allow typing if there arent 2 negative signs already
        if([self.inputCalcs hasSuffix:@"--"] == NO){
            [self.inputCalcs appendString:@"-"];
            self.input.text = self.inputCalcs;
        }
    }
    else if(button.tag == 11){
        [self.inputCalcs appendString:@"1"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 12){
        [self.inputCalcs appendString:@"2"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 13){
        [self.inputCalcs appendString:@"3"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 14){
        // replace existing operand with new pressed operand
        if ([self.inputCalcs hasSuffix:@"/"]
            || [self.inputCalcs hasSuffix:@"*"]
            || [self.inputCalcs hasSuffix:@"-"]){
            
            [self.inputCalcs replaceCharactersInRange:NSMakeRange(self.inputCalcs.length-1, 1) withString:@"+"];
            self.input.text = self.inputCalcs;
        }
        // append if not empty string or same operand already entered
        else if([self.inputCalcs isEqualToString: @""] == NO
                && [self.inputCalcs hasSuffix:@"+"] == NO){
            [self.inputCalcs appendString:@"+"];
            self.input.text = self.inputCalcs;
        }
    }
    else if(button.tag == 15){
        [self.inputCalcs appendString:@"0"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 16){
        // only allow entering if arg already entered and no operand before
        if([self.inputCalcs isEqualToString: @""] == NO
           && [self.inputCalcs hasSuffix:@"*"] == NO
           && [self.inputCalcs hasSuffix:@"/"] == NO
           && [self.inputCalcs hasSuffix:@"+"] == NO
           && [self.inputCalcs hasSuffix:@"-"] == NO){
            [self.inputCalcs appendString:@"."];
            self.input.text = self.inputCalcs;
        }
    }
    else{
        // only evaluate if not ending in operand and not empty
        if([self.inputCalcs hasSuffix:@"*"] == NO
           && [self.inputCalcs hasSuffix:@"-"] == NO
           && [self.inputCalcs hasSuffix:@"/"] == NO
           && [self.inputCalcs hasSuffix:@"+"] == NO
           && [self.inputCalcs isEqualToString:@""] == NO){
            NSExpression *expression = [NSExpression expressionWithFormat:self.inputCalcs];
            NSNumber *result = [expression expressionValueWithObject:nil context:nil];
            self.output.text = [result stringValue];
            
            self.done = YES;
        }
    }

}

// helper function to pick button label
- (NSString*) getButtonLabel:(NSInteger)tag{
    
    if(tag == 0){
        return @"C";
    }
    else if(tag == 1){
        return @"←";
    }
    else if(tag == 2){
        return @"÷";
    }
    else if(tag == 3){
        return @"7";
    }
    else if(tag == 4){
        return @"8";
    }
    else if(tag == 5){
        return @"9";
    }
    else if(tag == 6){
        return @"x";
    }
    else if(tag == 7){
        return @"4";
    }
    else if(tag == 8){
        return @"5";
    }
    else if(tag == 9){
        return @"6";
    }
    else if(tag == 10){
        return @"-";
    }
    else if(tag == 11){
        return @"1";
    }
    else if(tag == 12){
        return @"2";
    }
    else if(tag == 13){
        return @"3";
    }
    else if(tag == 14){
        return @"+";
    }
    else if(tag == 15){
        return @"0";
    }
    else if(tag == 16){
        return @".";
    }
    else{
        return @"=";
    }
}
@end
