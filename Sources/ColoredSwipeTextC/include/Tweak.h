#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <UIFontTTF/UIFont-TTF.h>
#import <Springboard/Springboard.h>
#import "RemoteLog.h"

@interface SBUILegibilityLabel : UIView {
    UILabel* _lookasideLabel;
}
@property (nonatomic,copy) NSAttributedString *attributedText;
@property (nonatomic,copy) NSString *string;
-(void)setTextColor:(UIColor *)arg1;
@end

@interface CSTeachableMomentsContainerView : UIView
@property (nonatomic,retain) SBUILegibilityLabel *callToActionLabel;
@end

@interface CSCoverSheetView : UIView
@property (nonatomic,retain) CSTeachableMomentsContainerView *teachableMomentsContainerView;
@end
