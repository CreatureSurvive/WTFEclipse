#include <UIColor+WTFE.h>

// AppStore

@interface AppStoreFadeInDynamicTypeButton : UIButton
@property (nonatomic, retain) CAGradientLayer *fadeLayer;
@end


// Safari

@interface SFDialogTextView : UIView {
    CAGradientLayer *_topGradient;
    CAGradientLayer *_bottomGradient;
    UITextView *_textView;
}
@end