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

// allow user interaction with output textfield but no editing
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}

// actions depending on button clicked
- (void) buttonClicked:(UIButton*)button{
    
    // start new expression continuing result of previous if operand pressed after =
    // clear everything if number or parenthesis pressed
    if(button.tag == 3 || button.tag == 7 || button.tag == 11 || button.tag == 15){
        if([self.output.text isEqualToString: @"0"] == NO){
            [self.inputCalcs setString:self.output.text];
            
            self.done = NO;
        }
    }
    else if(button.tag != 19 && button.tag != 18 && button.tag != 17){
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
        [self.inputCalcs appendString:@"("];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 2){
        [self.inputCalcs appendString:@")"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 3){
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
    else if(button.tag == 4){
        [self.inputCalcs appendString:@"7"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 5){
        [self.inputCalcs appendString:@"8"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 6){
        [self.inputCalcs appendString:@"9"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 7){
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
    else if(button.tag == 8){
        [self.inputCalcs appendString:@"4"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 9){
        [self.inputCalcs appendString:@"5"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 10){
        [self.inputCalcs appendString:@"6"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 11){
        // only allow typing if there arent 2 negative signs already
        if([self.inputCalcs hasSuffix:@"--"] == NO){
            [self.inputCalcs appendString:@"-"];
            self.input.text = self.inputCalcs;
        }
    }
    else if(button.tag == 12){
        [self.inputCalcs appendString:@"1"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 13){
        [self.inputCalcs appendString:@"2"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 14){
        [self.inputCalcs appendString:@"3"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 15){
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
    else if(button.tag == 16){
        [self.inputCalcs appendString:@"0"];
        self.input.text = self.inputCalcs;
    }
    else if(button.tag == 17){
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
    else if(button.tag == 18){
        if(self.inputCalcs.length > 0){
            [self.inputCalcs deleteCharactersInRange:NSMakeRange(self.inputCalcs.length-1, 1)];
            self.input.text = self.inputCalcs;
        }
    }
    else{
        // only evaluate if not ending in operand
        if([self.inputCalcs hasSuffix:@"*"] == NO
           && [self.inputCalcs hasSuffix:@"-"] == NO
           && [self.inputCalcs hasSuffix:@"/"] == NO
           && [self.inputCalcs hasSuffix:@"+"] == NO){
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
        return @"(";
    }
    else if(tag == 2){
        return @")";
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
