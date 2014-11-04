//
//  EditableCollectionViewCell.m
//  DeleteButton
//
//  Created by Oleksandr Kiporenko on 10/21/14.
//  Copyright (c) 2014 Oleksandr Kiporenko. All rights reserved.
//

#import "EditableCollectionViewCell.h"

@interface EditableCollectionViewCell() <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIView *contentSnapshotView;
@property (nonatomic) UIButton *delButton;
@property UIPanGestureRecognizer *panGesture;
@property CGPoint startPoint;
@property BOOL isDeleteButtonShow;
@end

@implementation EditableCollectionViewCell

CGFloat const buttonHeight = 20;

@synthesize deleteMode = _deleteMode;



- (void)setIsDeleteButtonShow:(BOOL)isDeleteButtonShow {
    if (isDeleteButtonShow) {
        if (!self.contentSnapshotView) {
            self.contentSnapshotView = [self.contentView snapshotViewAfterScreenUpdates:NO];
            self.contentSnapshotView.backgroundColor = self.backgroundColor;
            [self addSubview:self.delButton];
            [self addSubview:self.contentSnapshotView];
            self.contentView.hidden = YES;
        }
    } else {
        self.contentView.hidden = NO;
        [self.delButton removeFromSuperview];
        [self.contentSnapshotView removeFromSuperview];
        self.contentSnapshotView = nil;
    }
}

- (BOOL)isDeleteButtonShow {
    return self.contentSnapshotView != nil;
}

- (void)setDeleteMode:(BOOL)deleteMode {
    if (_deleteMode == deleteMode && _deleteMode == self.isDeleteButtonShow) {
        return;
    }
    self.panGesture.enabled = NO;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect frame = [self.contentSnapshotView frame];
                         frame.origin.y = deleteMode ? buttonHeight : self.startPoint.y;
                         [self.contentSnapshotView setFrame:frame];
                     }
                     completion:^(BOOL finished) {
                         self.isDeleteButtonShow = deleteMode;
                         _deleteMode = deleteMode;
                         self.panGesture.enabled = !deleteMode;
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
        [_delButton addTarget:self action:@selector(delButtonDidTap) forControlEvents:UIControlEventTouchUpInside];
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
    CGPoint trans = [sender translationInView:self.contentView];
    if (trans.y < 0) {
        trans.y = 0;
    }
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startPoint = self.frame.origin;
        self.isDeleteButtonShow = YES;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat shift = trans.y;
        if (shift >= buttonHeight) {
            shift = buttonHeight + (shift - buttonHeight)/5;
        }
        CGRect frame = [self.contentSnapshotView frame];
        frame.origin.y = self.startPoint.y + shift;
        [self.contentSnapshotView setFrame:frame];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [self setDeleteMode:trans.y >= buttonHeight/2];
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self setDeleteMode:NO];
}

@end
