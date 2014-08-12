//
//  AlertWithBlock.m
//

#import "AlertWithBlock.h"

@implementation AlertWithBlock{
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(AlertWithBlock*)alert:(NSString *)message okbutton:(NSString *)buttontext withBlock:(blockaction)action{
    return [self alert:message okbutton:nil withBlock:nil cancelButton:buttontext cancelBlock:action];
}

+(AlertWithBlock*)alert:(NSString *)message okbutton:(NSString *)buttontext withBlock:(blockaction)action cancelButton:(NSString *)canceltext cancelBlock:(blockaction)cancelaction{
    NSMutableArray* actions = [NSMutableArray new];
    NSMutableArray* buttontexts = [NSMutableArray new];
    if (buttontext) {
        [buttontexts addObject:buttontext];
        if (action){
            [actions addObject:action];
        }else{
            [actions addObject:[NSNull new]];
        }
    }
    if (canceltext) {
        [buttontexts addObject:canceltext];
        if (cancelaction) {
            [actions addObject:cancelaction];
        }else{
            [actions addObject:[NSNull new]];
        }
    }
    if (buttontexts.count==0) {
        return nil;
    }
    return [self alert:message buttons:buttontexts withBlocks:actions];
}

+(AlertWithBlock*)alert:(NSString *)message buttons:(NSArray *)buttontexts withBlocks:(NSArray *)arrayOfActions{
    assert(buttontexts.count ==  arrayOfActions.count);
    
    AlertWithBlock* alert = [[AlertWithBlock alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    alert.delegate = alert;
    alert.actionsArray = arrayOfActions;
    for (id buttontext in buttontexts) {
        [alert addButtonWithTitle:[buttontext description]];
    }
    [alert show];
    return alert;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    if (buttonIndex<self.actionsArray.count && buttonIndex>=0) {
        id block = self.actionsArray[buttonIndex];
        if ([block isKindOfClass:NSClassFromString(@"NSBlock")]) {
            ((blockaction)block)();
        }
    }
}

@end
