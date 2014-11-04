//
//  EditableCollectionViewCell.h
//  DeleteButton
//
//  Created by Oleksandr Kiporenko on 10/21/14.
//  Copyright (c) 2014 Oleksandr Kiporenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditableCollectionViewCell;

@protocol EditableCollectionViewCellDelegate <NSObject>

@optional
// called when a gesture recognizer attempts to transition out of UIGestureRecognizerStatePossible. returning NO causes it to transition to UIGestureRecognizerStateFailed
- (BOOL)editableCellDeleteModeShouldBegin:(EditableCollectionViewCell*)editableCell;
- (void)editableCellDelButtonDidTap:(EditableCollectionViewCell*)editableCell;

@end

@interface EditableCollectionViewCell : UICollectionViewCell

@property (getter=isDeleteMode) BOOL deleteMode;
@property(nonatomic, assign) id<EditableCollectionViewCellDelegate> delegate;

@end
