//
//  EditableCollectionViewCell.m
//  DeleteButton
//
//  Created by Oleksandr Kiporenko on 10/21/14.
//  Copyright (c) 2014 Oleksandr Kiporenko. All rights reserved.
//

#import "EditableCollectionViewCell.h"

@interface EditableCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIView *editableView;
@property (nonatomic) UIButton *delButton;
@property UIPanGestureRecognizer *panGesture;
@property CGPoint startPoint;
@end

@implementation EditableCollectionViewCell

CGFloat const buttonHeight = 20;

@synthesize deleteMode = _deleteMode;

- (void)setEditableView:(UIView *)editableView {
    if (_editableView != editableView) {
        _editableView = editableView;
        self.startPoint = editableView.frame.origin;
    }
}

- (void)setDeleteMode:(BOOL)deleteMode {
    if (_deleteMode == deleteMode && self.delButton.hidden == !deleteMode) {
        return;
    }
    self.panGesture.enabled = NO;
    //NSLog(@"%@%@", @"panGesture.enabled = ", self.panGesture.enabled ? @"YES" : @"NO");
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = self.editableView.frame;
                         //CGRect frame = self.contentView.frame;
                         frame.origin.y = deleteMode ? buttonHeight : self.startPoint.y;
                         self.editableView.frame = frame;
                         //self.contentView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         self.delButton.hidden = !deleteMode;
                         _deleteMode = deleteMode;
                         self.panGesture.enabled = !deleteMode;
                         //NSLog(@"%@%@", @"panGesture.enabled = ", self.panGesture.enabled ? @"YES" : @"NO");
                     }];
}

- (BOOL)isDeleteMode {
    return _deleteMode;
}

- (UIButton*)delButton {
    if (_delButton == nil) {
        CGRect rect = self.bounds;
        rect.size.height = 20;
        _delButton = [[UIButton alloc] init];
        [_delButton setFrame:rect];
        [_delButton setBackgroundColor:[UIColor redColor]];
        [_delButton setTitle:@"Delete" forState:UIControlStateNormal];
        [_delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_delButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_delButton setHidden:YES];
        [_delButton addTarget:self action:@selector(delButtonDidTap) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView insertSubview:_delButton atIndex:0];
        //[self.backgroundView addSubview:_delButton];
    }
    return _delButton;
}

- (void)delButtonDidTap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editableCellDelButtonDidTap:)]) {
        __weak EditableCollectionViewCell *weakSelf = self;
        [self.delegate editableCellDelButtonDidTap:weakSelf];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanGestureInvoke:)];
        [self addGestureRecognizer:self.panGesture];
        self.panGesture.delegate = self;
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.delegate && [self.delegate respondsToSelector:@selector(editableCellDeleteModeShouldBegin:)]) {
        __weak EditableCollectionViewCell *weakSelf = self;
        return [self.delegate editableCellDeleteModeShouldBegin:weakSelf];
    }
    return YES;
}

- (void)didPanGestureInvoke:(UIPanGestureRecognizer*)sender {
    //NSLog(@"%@%@", @"didPanGestureInvoke enabled = ", self.panGesture.enabled ? @"YES" : @"NO");
    //CGPoint trans = [sender translationInView:self.editableView];
    CGPoint trans = [sender translationInView:self.editableView];
    if (trans.y < 0) {
        trans.y = 0;
    }
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.delButton.hidden = NO;
        //NSLog(@"%@", @"State began");
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat shift = trans.y;// + self.editableView.frame.origin.y;
        if (shift >= buttonHeight) {
            shift = buttonHeight + (shift - buttonHeight)/5;
        }
        CGRect frame = self.editableView.frame;
        //frame.origin.x = self.startPoint.x + trans.x;
        frame.origin.y = self.startPoint.y + shift;
        self.editableView.frame = frame;
        //NSLog(@"%@", @"State changed");
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [self setDeleteMode:trans.y >= buttonHeight/2];
        //NSLog(@"%@", @"State ended");
    }
    //NSLog(@"%@", NSStringFromCGPoint(trans));
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self setDeleteMode:NO];
}

@end
