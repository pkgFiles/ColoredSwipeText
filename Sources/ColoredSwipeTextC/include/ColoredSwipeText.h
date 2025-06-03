#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <UIFontTTF/UIFont-TTF.h>
#import <Springboard/Springboard.h>
#import "RemoteLog.h"

@interface SBFTouchPassThroughView : UIView
@end

@interface CSCoverSheetViewBase : SBFTouchPassThroughView
@end

@interface SBUILegibilityLabel : UIView
-(void)setTextColor:(UIColor *)arg1;
@end

@interface CSTeachableMomentsContainerView : CSCoverSheetViewBase
@property (nonatomic,retain) SBUILegibilityLabel *callToActionLabel;
@end

@interface CSCoverSheetView : UIView
@property (nonatomic,retain) CSTeachableMomentsContainerView *teachableMomentsContainerView;
@end
