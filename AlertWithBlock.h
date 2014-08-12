//
//  AlertWithBlock.h
//

#import <UIKit/UIKit.h>

typedef void(^blockaction)(void);

@interface AlertWithBlock : UIAlertView<UIAlertViewDelegate>

@property (nonatomic, strong) NSArray* actionsArray;

//Populates an alert with one button, the block is executed after the button is pressed.
+(AlertWithBlock*)alert:(NSString*)message okbutton:(NSString*)buttontext withBlock:(blockaction)action;

//Populates an alert with OK button and Cancel button, both comes with a block that will be executed after pressed.
+(AlertWithBlock*)alert:(NSString *)message okbutton:(NSString *)buttontext withBlock:(blockaction)action cancelButton:(NSString*)canceltext cancelBlock:(blockaction)cancelaction;

//Populates an alert with a couple of buttons and corresponding actions. The amount of buttons and actions must match.
+(AlertWithBlock*)alert:(NSString *)message buttons:(NSArray*)buttontexts withBlocks:(NSArray*)arrayOfActions;

@end
