#include <WTFEclipse.h>

#pragma mark - AppStore

%hook AppStoreFadeInDynamicTypeButton


- (void)layoutSubviews {
    %orig;

    // shit me, why cant we use 'self' within a hooked swift class. what a nightmare
    AppStoreFadeInDynamicTypeButton *button = (AppStoreFadeInDynamicTypeButton *)self;

    // looks like noctis sets the background color of the button itself, so we can use that if its set
    // for eclipse, well need to travers to the cell view and get its background color
    UIColor *backColor = button.backgroundColor ? : button.superview.superview.superview.backgroundColor;

    // just in case insanity happens, and neither the cell or the button have a color then prevent a crash
    if (backColor) {

        // apply the color to the gradient with a left facing fade, (possibly needs to change for R to L languages?)
        button.fadeLayer.colors = @[(id)[backColor colorWithAlphaComponent:0].CGColor, (id)backColor.CGColor];
    }
}


%end


#pragma mark - Safari

%hook SFDialogTextView

- (void)layoutSubviews {
    %orig;

    // get a pointer to the top and bottom gradients
    CAGradientLayer *bottom = [self valueForKey:@"_bottomGradient"], *top = [self valueForKey:@"_topGradient"];

    // get the current background color of the alert
    UIColor *backColor = self.superview.backgroundColor;

    // prevent those crashes
    if (backColor && top && bottom) {

        // fade bottom to top
        bottom.colors = @[(id)[backColor colorWithAlphaComponent:0].CGColor, (id)backColor.CGColor];
        // fade top to bottom
        top.colors = @[(id)backColor.CGColor, (id)[backColor colorWithAlphaComponent:0].CGColor];

        // fix the text color to ensure legibility
        UITextView *textView = [self valueForKey:@"_textView"];
        
        if (textView) {

            // set text color to light/dark based on the brightness of the background color of the alert
            textView.textColor = [backColor _wtf_isBrightColor] ? [UIColor darkTextColor] : [UIColor lightTextColor];
        }
    }
}

%end

#pragma mark - Init

%ctor {
    @autoreleasepool {
        // because hooking swift sucks
        %init(AppStoreFadeInDynamicTypeButton = NSClassFromString(@"AppStore.FadeInDynamicTypeButton"));
    }
}